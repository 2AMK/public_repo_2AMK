[[rust]]


No Rust, temos o shadowing em que podemos criar a nova variável com o mesmo valor e com outro valor, e tornar o valor anterior inacessível.
- Ela permite a transformação dos dados sem precisar mut
```rust
    let mut guess: String = String::new();
    let secret_number: i32 = rand::thread_rng().gen_range(1..10);

    println!("The secret number is: {secret_number}");
    stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");

    let guess: i32 = guess.trim().parse().expect("You have to input number!");
```
- Aqui permite o shadowing em que a variável `guess` foi "reatribuída" com outro valor e tipo diferente.
- Geralmente o shadowing é bem útil para fazer as transformações lineares do mesmo dado.
- Tecnicamente o shadowing cria uma nova variável sobre a variável já existente, e o que já tem antes deixa de existir.
____
Lembrando que há diferença no uso de `mut` e uso de shadowing na prática.
- Ao usar mut, estamos só alterando o valor da mesma variável. Ela não permite mudar o tipo diferente.
- Porém no shadowing, ele cria uma variável nova e também permite alterar o tipo!

`mut` é melhor utilizado para acumular o mesmo estado ou usar em mesmo loop, e o shadowing representa as transformações passo a passo.
- De modo geral, é mais recomendável usar shadowing invés de `mut` pois ajuda a evitar os bugs.

Ou seja, o shadowing é quando usamos o let para a mesma variável como no exemplo abaixo:
```rust
let x: i32 = 5;
let x = x + 1;
```

E em mut, seria assim:
```rust
let mut x: i32 = 5;
x = x + 1;
```