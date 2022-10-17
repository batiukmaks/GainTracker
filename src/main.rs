use actix_web::{get,post, web::{self,Json}, App, HttpServer, HttpResponse};
use serde :: {Serialize, Deserialize};
use std::{sync::Mutex, collections::HashMap};
use actix_web::middleware::Logger;

#[derive(Debug, Deserialize, Serialize)]
struct Exersize{
    name: String,
}



struct AppStateWithList{
    exersize_list: Mutex<HashMap<i32,Exersize>>,
}

#[get("/ex/{num}")]
async fn get_ex(data: web::Data<AppStateWithList>, path :web::Path<i32>) -> HttpResponse {
    let list = data.exersize_list.lock().unwrap();
    let num = path.into_inner();

    if list.contains_key(&num){
        let ex = list.get(&num).unwrap();
        HttpResponse::Ok().json(ex)
    }else{
        HttpResponse::BadRequest().body("incorect id")
    }
}

#[post("/ex/{num}")]
async fn add_ex(data: web::Data<AppStateWithList>, path :web::Path<i32>,info: Json<Exersize>) -> HttpResponse {
    let mut list = data.exersize_list.lock().unwrap();
    let num = path.into_inner();

    if list.contains_key(&num){
        HttpResponse::BadRequest().body("incorect id")
    }else{
        let ex = Exersize{
            name: info.name.clone(),
        };
        list.insert(num,ex);
        HttpResponse::Ok().json(info)
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "info");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    // Note: web::Data created _outside_ HttpServer::new closure
    let mut list = HashMap::new();
    let ex1 = Exersize{
        name: String::from("bench press"),   
    };
    let ex2 = Exersize{
        name: String::from("leg press"),   
    };
    list.insert(1, ex1);
    list.insert(2, ex2);
    let exersize_list = web::Data::new(AppStateWithList {
        exersize_list:  Mutex::new(list),
    });

    HttpServer::new(move || {
        let logger = Logger::default();
        // move counter into the closure
        App::new()
            .wrap(logger)
            .app_data(exersize_list.clone())// <- register the created data
            .service(get_ex)
            .service(add_ex)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}