use std::fs::*;
use std::io::*;

struct State {
    dx: i32,
    dy: i32
}

fn next(cmd: &String, mut ship: State, mut wayp: State) -> (State, State) {
    let mag: i32 = cmd[1..].parse().unwrap();
    match cmd.as_bytes()[0] as char {
        'N' => wayp.dy -= mag,
        'E' => wayp.dx += mag,
        'S' => wayp.dy += mag,
        'W' => wayp.dx -= mag,
        'L' => {
            for _ in 0..(mag / 90).rem_euclid(4) {
                let swap = wayp.dy;
                wayp.dy = -wayp.dx;
                wayp.dx = swap;
            }
        }
        'R' => {
            for _ in 0..(mag / 90).rem_euclid(4) {
                let swap = wayp.dx;
                wayp.dx = -wayp.dy;
                wayp.dy = swap;
            }
        }
        'F' => {
            ship.dx += wayp.dx * mag;
            ship.dy += wayp.dy * mag;
        }
        _ => ()
    }
    return (ship, wayp);
}

fn main() {
    let file = File::open("input.txt").expect("");
    let reader = BufReader::new(file);
    let mut ship = State{dx:0, dy:0};
    let mut wayp = State{dx:10, dy:-1};
    for line in reader.lines() {
        let (next_ship, next_wayp) = next(&line.unwrap(), ship, wayp);
        ship = next_ship;
        wayp = next_wayp;
        println!("{} {}; {} {}", ship.dx, ship.dy, wayp.dx, wayp.dy);
    }
    println!("{}", ship.dx.abs() + ship.dy.abs());
}
