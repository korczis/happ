#![feature(test)]
extern crate test;

fn main() {
    println!("Hello, world!");
}

pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;
    use test::Bencher;
    #[test]
    fn it_works() {
        assert_eq!(add(1, 2), 3);
    }

    #[bench]
    fn bench_add_two(b: &mut Bencher) {
        b.iter(|| add(1,2));
    }
}