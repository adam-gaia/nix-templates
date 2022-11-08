#![allow(unused)] // TODO: remove
use anyhow::Result;
use clap::Parser;
use log::{trace, debug, info, warn, error};

/// TODO: add description
#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// TODO: add arguments
    #[arg(short, long)]
    todo: String
}

fn main() -> Result<()> {
    env_logger::init();
    let args = Args::parse();
    println!("Hello, world!");
    Ok(())
}

