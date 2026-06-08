use std::io;

pub fn parser_stdin<T>() -> T
where
    T: std::str::FromStr,
    T::Err: std::fmt::Debug,
{
    let mut value: String = String::new();
    io::stdin()
        .read_line(&mut value)
        .expect("Erro ao ler input");
    
    let value: T = value.trim().parse().unwrap();
    value

}