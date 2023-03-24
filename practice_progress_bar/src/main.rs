use std::{thread::sleep, time::Duration};

const CLEAR: &str = "\x1B[2J\x1B[1;1H";

struct Unbounded;
struct Bounded {
    size: usize,
    delims: (char, char),
}

struct Progress<Iter, Bound> {
    iter: Iter,
    i: usize,
    bound: Bound,
}

impl<Iter> Progress<Iter, Unbounded> {
    fn new(iter: Iter) -> Self {
        Progress {
            iter,
            i: 0,
            bound: Unbounded,
        }
    }
}

trait ProgressDisplay: Sized {
    fn display<Iter>(&self, progress: &Progress<Iter, Self>);
}

impl ProgressDisplay for Unbounded {
    fn display<Iter>(&self, progress: &Progress<Iter, Unbounded>) {
        println!("{}", "*".repeat(progress.i));
    }
}

impl ProgressDisplay for Bounded {
    fn display<Iter>(&self, progress: &Progress<Iter, Bounded>) {
        println!(
            "{}{}{}{}",
            self.delims.0,
            "*".repeat(progress.i),
            " ".repeat(self.size - progress.i),
            self.delims.1
        );
    }
}

impl<Iter> Progress<Iter, Bounded>
where
    Iter: ExactSizeIterator,
{
    fn with_delims(mut self, delims: (char, char)) -> Self {
        self.bound.delims = delims;
        self
    }
}

impl<Iter, Bound> Iterator for Progress<Iter, Bound>
where
    Iter: Iterator,
    Bound: ProgressDisplay,
{
    type Item = Iter::Item;
    fn next(&mut self) -> Option<Self::Item> {
        println!("{}", CLEAR);
        self.bound.display(&self);
        self.i += 1;
        self.iter.next()
    }
}

trait ProgressExt: Sized {
    fn progress(self) -> Progress<Self, Unbounded>;
}

impl<Iter> Progress<Iter, Unbounded> where Iter: ExactSizeIterator {
    fn with_bound(mut self) -> Progress<Iter, Bounded> {
        let bound = Bounded {
            delims: ('[',']'),
            size: self.iter.len()
        };
        Progress { iter: self.iter, i: self.i, bound }
    }
}

impl<Iter> ProgressExt for Iter {
    fn progress(self) -> Progress<Self, Unbounded> {
        Progress::new(self)
    }
}

fn expensive_cal() {
    sleep(Duration::from_secs(1));
}

fn main() {
    let delims = ('<','>');
    for n in (0 .. ).progress().with_bound().with_delims(delims) {
        expensive_cal();
    }
    let v = vec![1, 2, 3];
    for n in v.iter().progress().with_bound().with_delims(delims) {
        expensive_cal();
    }
}
