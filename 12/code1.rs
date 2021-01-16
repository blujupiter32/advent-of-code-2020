use std::fs::*;
use std::io::*;

struct State {
    dx: i16,
    dy: i16,
    dir: i16
}

fn next(cmd: &String, mut state: State) -> State {
    let mag: i16 = cmd[1..].parse().unwrap();
    match cmd.as_bytes()[0] as char {
        'N' => state.dy -= mag,
        'E' => state.dx += mag,
        'S' => state.dy += mag,
        'W' => state.dx -= mag,
        'L' => state.dir -= mag,
        'R' => state.dir += mag,
        'F' => match (state.dir / 90).rem_euclid(4) {
            0 => state.dx += mag,
            1 => state.dy += mag,
            2 => state.dx -= mag,
            3 => state.dy -= mag,
            _ => ()
        }
        _ => ()
    }
    return state;
}

fn main() {
    let file = File::open("input.txt").expect("");
    let reader = BufReader::new(file);
    let mut state = State{dx:0, dy:0, dir:0};
    for line in reader.lines() {
        state = next(&line.unwrap(), state);
    }
    println!("{}", state.dx.abs() + state.dy.abs());
}
