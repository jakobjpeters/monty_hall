use rand::{thread_rng, Rng};
use std::{env::args, iter::zip};

fn main() {
    match args().nth(1).map(|s| s.parse::<u32>()) {
        Some(Ok(n)) if n > 0 => {
            let (mut rng, mut counts) = (thread_rng(), [0, 0]);

            for _ in 0..n {
                counts[(rng.gen_range(1..4) == rng.gen_range(1..4)) as usize] += 1;
            }

            for (strategy, count) in zip(["switch", "keep"], counts) {
                println!("P(success | {strategy}) ≈ {:.2}", count as f32 / n as f32);
            }
        }
        _ => println!(
            "Requires an natural number of iterations from `[1, 2 ^ 32)` to simulate. For example, `monty_hall 1`."
        ),
    }
}
