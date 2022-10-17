use actix_web::{ web::{self}, App, HttpServer};
use std::{sync::Mutex, collections::HashMap};
use actix_web::middleware::Logger;

use crate::workouts::*;

mod workouts;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "info");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    // Note: web::Data created _outside_ HttpServer::new closure
    let mut list_ex = HashMap::new();
    let ex1 = Exercise{
        name: String::from("bench press"),   
    };
    let ex2 = Exercise{
        name: String::from("leg press"),   
    };
    list_ex.insert(1, ex1.clone());
    list_ex.insert(2, ex2.clone());
    let mut workout_list = HashMap::new();

    let workout1 = Workout{
        name: String::from("basic workout"),
        id: 1,
        list_of_exs: vec![ex1,ex2],
    };

    workout_list.insert(1, workout1);
    let data_state = web::Data::new(AppState {
        exercise_list:  Mutex::new(list_ex),
        workouts_list:  Mutex::new(workout_list),
    });

    HttpServer::new(move || {
        let logger = Logger::default();
        // move counter into the closure
        App::new()
            .wrap(logger)
            .app_data(data_state.clone())// <- register the created data
            .service(get_ex)
            .service(add_ex)
            .service(get_workout)
            .service(get_all_workouts)
            .service(delete_workout)
            .service(add_workout)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}