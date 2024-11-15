
#import "@preview/touying:0.5.3": *
#import emoji: car, crab, goat, rocket
#import themes.simple: *

#let author = "Jakob Peters (they/them)"
#let (success, failure) = (rect(car), rect(goat))

#set document(author: author, title: "Monty Hall")
#set rect(width: 100%)
#set text(font: "Cantarell")

#show link: address => text(blue)[#address]
#show: simple-theme.with(aspect-ratio: "16-9", primary: blue.darken(50%), header:
    [A Blazingly Fast #rocket Simulation of the Monty Hall Problem (written in Rust #crab)])

#title-slide[
    = Simulating the\ Monty Hall Problem

    \

    by #author

    November 14th, 2024
]

// Who here is familiar with the Monty Hall Problem?

== About Me

// Hi everyone! I'm new here, so here's an introduction.

#pause

- I really like Rust

#pause

- I have not written very much Rust

#pause

- I should have chosen a problem that requires more than 13 lines

#pause

- That's literally everything about me

== These slides were made in Typst 

#image("rust_meme.jpg", height: 84%)

== blah blah blah

#quote(block: true, attribution: [Craig F. Whitaker's letter quoted in Marilyn vos Savant's "Ask Marilyn" column in Parade magazine in 1990])[
    Suppose you're on a game show, and you're given the choice of three doors: Behind one door is a car; behind the others, goats. You pick a door, say No. 1, and the host, who knows what's behind the doors, opens another door, say No. 3, which has a goat. He then says to you, "Do you want to pick door No. 2?" Is it to your advantage to switch your choice?
]

== Formal Proof

// Let's be rigorous about this.

#pause

1. It obviously does not matter which door you pick

// Who agrees?
// Who disagrees?
// To those who disagree:

#pause

2. This presentation has code on slide 7, promise

#pause 

3. See 1

== Confirmation Bias

// Let's run the simulation to prove, again, that I'm right.

```
> monty_hall 1000000
P(success | switch) ≈ 0.67
P(success | keep) ≈ 0.33
```

#pause

#text(fill: gradient.linear(..color.map.rainbow), size: 128pt, box[_wat_])

== boring stuff...

#grid(align: center, columns: range(5).map(_ => 3cm),
    grid.cell(colspan: 3, rect[Doors]),
    grid.cell(colspan: 2, rect[Strategy]),
    ..(1, 2, 3, [switch], [keep]).map(x => rect[#x]),
    success, failure, failure, failure, success,
    failure, success, failure, success, failure,
    failure, failure, success, success, failure
)

// The choices result in a `success` twice for `switch` and once for `keep`

- Each row is a possible world where the initial choice is 1

// This generalizes for initial choices of 2 and 3

#pause

- Each strategy has an opposite outcome

// Therefore, the simulation can test each strategy simultaneously

#pause

- Each strategy's outcome is determined by the initial choice

// Therefore, the simulation only needs to randomly select the initial state and choice

== Show Code Already

#text(size: 20pt)[
    ```rust
    use rand::{thread_rng, Rng};

    fn monty_hall(n: u32) {
        let (mut rng, mut counts) = (thread_rng(), [0, 0]);

        for _ in 0..n {
            counts[(rng.gen_range(1..4) == rng.gen_range(1..4)) as usize] += 1;
        }

        for (strategy, count) in std::iter::zip(["switch", "keep"], counts) {
            println!("P(success | {strategy}) ≈ {:.2}", count as f32 / n as f32);
        }
    }
  ```
]

== hire me

// That's all, folks!

```rust
fn blazingly_fast_monty_hall() {
    println!("P(success | switch) = 2 / 3")
    println!("P(success | keep) = 1 / 3")
}
```

#v(1em)

```
> blazingly_fast_monty_hall
P(success | switch) = 2 / 3
P(success | keep) = 1 / 3
```

#v(1em)

#link("github.com/jakobjpeters/monty_hall")
