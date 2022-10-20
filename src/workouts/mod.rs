use std::{collections::HashMap, sync::Mutex};
use actix_web::{get,post,delete, web::{self,Json}, HttpResponse};
use serde :: {Serialize, Deserialize};



#[derive(Debug,Clone, Deserialize, Serialize)]
pub struct Exercise{
    pub name: String,
}


#[derive(Debug,Clone, Deserialize, Serialize)]
pub struct Workout{
    pub id: i32,
    pub name: String,
    pub list_of_exs: Vec<Exercise>
}

#[derive(Debug,Clone, Deserialize, Serialize)]
struct WorkoutAdd{
    pub id: i32,
    pub name: String,
    pub list_of_exs_ids: Vec<i32>
}

#[derive(Debug,Clone, Deserialize, Serialize)]
struct ExerciseAdd{
    pub id: i32,
    pub name: String,
}


pub struct AppState{
    pub exercise_list: Mutex<HashMap<i32,Exercise>>,
    pub workouts_list: Mutex<HashMap<i32,Workout>>,
}


#[post("/workouts")]
async fn add_workout(data: web::Data<AppState>,info: Json<WorkoutAdd>) -> HttpResponse {
    let mut list_workouts = data.workouts_list.lock().unwrap();
    let list_exers = data.exercise_list.lock().unwrap();
    let id = info.id;
    if list_workouts.contains_key(&id){
        return HttpResponse::BadRequest().body("id already used")
    };
    let ex_list = &info.list_of_exs_ids;
    for i in ex_list{
        if !list_exers.contains_key(&i){
            return HttpResponse::BadRequest().body("incorect exercise id")
        };
    };
    let mut workout = Workout{
        id: id,
        name: info.name.clone(),
        list_of_exs: Vec::new(),
    };
    for i in ex_list{
        workout.list_of_exs.push(list_exers.get(i).unwrap().clone());
    };
    list_workouts.insert(id,workout.clone());
    HttpResponse::Ok().json(workout)
    
}

#[get("/workouts/{id}")]
async fn get_workout(data: web::Data<AppState>, path :web::Path<i32>) -> HttpResponse {
    let list = data.workouts_list.lock().unwrap();
    let id = path.into_inner();

    if list.contains_key(&id){
        let workout = list.get(&id).unwrap();
        HttpResponse::Ok().json(workout)
    }else{
        HttpResponse::BadRequest().body("incorect id")
    }
}


//TODO user authentification
#[delete("/workouts/{id}")]
async fn delete_workout(data: web::Data<AppState>, path :web::Path<i32>) -> HttpResponse {
    let mut list = data.workouts_list.lock().unwrap();
    let id = path.into_inner();

    if list.contains_key(&id){
        let workout = list.remove(&id);
        HttpResponse::Ok().json(workout)
    }else{
        HttpResponse::NotFound().body("incorect id")
    }
}

#[get("/workouts")]
async fn get_all_workouts(data: web::Data<AppState>) -> HttpResponse {
    let list = data.workouts_list.lock().unwrap();
    //let mut vec = Vec::new();
    let b: Vec<Workout> = list.values().cloned().collect::<Vec<Workout>>();
            
    HttpResponse::Ok().json(b)
}



#[get("/ex/{id}")]
async fn get_ex(data: web::Data<AppState>, path :web::Path<i32>) -> HttpResponse {
    let list = data.exercise_list.lock().unwrap();
    let id = path.into_inner();

    if list.contains_key(&id){
        let ex = list.get(&id).unwrap();
        HttpResponse::Ok().json(ex)
    }else{
        HttpResponse::BadRequest().body("incorect id")
    }
}

#[post("/ex")]
async fn add_ex(data: web::Data<AppState>, info: Json<ExerciseAdd>) -> HttpResponse {
    let mut list = data.exercise_list.lock().unwrap();
    let id = info.id;

    if list.contains_key(&id){
        HttpResponse::BadRequest().body("id already exists")
    }else{
        let ex = Exercise{
            name: info.name.clone(),
        };
        list.insert(id,ex);
        HttpResponse::Ok().json(info)
    }
}