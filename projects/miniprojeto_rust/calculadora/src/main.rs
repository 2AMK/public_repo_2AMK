use std::io;


fn main() {
    loop {
        // Primeiro input
        println!("Insira o primeiro input: ");
        let input1: f64 = stdin_parser(); // Fazer um stdin_parser

        // Segundo input
        println!("Insira o segundo input: ");
        let input2: f64 = stdin_parser();

        // Operador
        println!("Insira o operador: ");
        let operador: String = stdin_parser();

        // Print
        println!("Primeiro input: {}", input1);
        println!("Segundo input: {}", input2);
        println!("Operador: {}", operador);


        // Cálculo
        let resultado: f64 = calculadora(input1, input2, operador.as_str()).unwrap();
        // Resultado
        println!("Resultado: {}", resultado);
        

        // Perguntar se quer prosseguir
        println!("Quer prosseguir? (S/N)");
        let continuar: String = stdin_parser();

        if !fn_continuar(&continuar) {
            break;
        }
    }
}
#[derive(Debug)]
enum E {
    OperadorInvalido
}



fn stdin_parser<T>() -> T 
where
    T: std::str::FromStr,
    T::Err: std::fmt::Debug,

{
    let mut value = String::new();
    io::stdin()
            .read_line(&mut value)
            .expect("Erro ao ler input");

    let value: T = value.trim().parse().unwrap();
    value
}


fn calculadora(input1: f64, input2: f64, operador: &str) -> Result<f64, E> {
    match operador {
        "+" => Ok(input1 + input2),
        "-" => Ok(input1 - input2),
        "*" => Ok(input1 * input2),
        "/" => Ok(input1 / input2),
        _ => return Err(E::OperadorInvalido)
    }
}


fn fn_continuar(value: &String) -> bool {
    let value_result = &value.to_lowercase();

    if value_result == "s" {
        true
    } else if value_result == "n" {
        false
    } else {
        println!("Opção inválida");
        panic!();
    }
}