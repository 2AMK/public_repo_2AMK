[[rust]]

Os generics são caracterizados por usar `<T>` que denota como "usar quaisquer tipos concretos" do Rust, e são muito úteis pois permite reduzir a duplicidade nos códigos.

Para escrever um Generic, tem que escrever assim:
```rust
fn exemplo_funcao <T>(lista: &[T] ) ->{} 
```

# Uso em Structs

Para os structs, podemos escrever assim:
```Rust
struct Ponto<T>(
	x: T, 
	y: T
)

fn main() {
	let inteiro = Ponto {x: 10, y: 25};
	let float = Ponto {x: 25.3, y:1.9};

} 
```
- Importante também lembrar que nós só usamos única notação de `T`, o que significa que não podemos misturar entre os diferentes tipos de dados como no exemplo abaixo:
```Rust
struct Ponto<T>(
	x: T, 
	y: T
)

let misturado = Ponto {x: 10, y: 2.4} // Errado! 
```
- Já que, uma vez que o tipo é especificado no primeiro argumento do tipo genérico `T`, o compilador do Rust assume que esse o segundo argumento do struct seja do mesmo tipo do primeiro. 

Também é possível usar uma combinação de "tipos genéricos" como `<T, U, V>`. Essas letras são por convenção no Rust, ou seja, a próxima letra do T deve ser U, e assim por diante.

Dessa forma, precisa incluir a outra variável do tipo genérico como no exemplo abaixo. 
```Rust
struct Ponto<T, U>(
	x: T, 
	y: U
)

let misturado = Ponto {x: 10, y: 2.4} // Agora está correto! 
```
- `U` representa o outro tipo, além do `T`.



# Uso em Enum
Também podemos notar que alguns Enums como `Option` e `Result` fazem o uso de genéricos como no exemplo abaixo 
```Rust
#![allow(unused)]
fn main() {
enum Option<T> {
    Some(T),
    None,
	}
}
```

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

# Uso em métodos

É importante saber como diferenciar entre Genérico usado em Structs e Genérico usado em Métodos. Ambos podem coexistir ao mesmo tempo.

Ou seja, para o Struct com genérico pode ter qualquer tipo, como nesse exemplo:
```Rust
struct Point<T> {
    x: T,
    y: T,
}
```

E também temos 2 formas diferentes de `impl`:
- É possível fazer a implementação do método usando `<T>`, o que significa que esse método existe para qualquer tipo de dados do Struct `Point`.
- Mas também conseguimos implementar o método apenas para um tipo específico de dados.


Segue o exemplo abaixo:
```Rust
fn main(){

    let num_inteiro = Point{x: 10, y: 4};
    let coord = Point{x: 2.4, y: 20.4};
    

    println!("{:?}", num_inteiro);
    println!("num_inteiro.x = {}", num_inteiro.x());
    println!("coord.distance_from_origin = {}", coord.distance_from_origin());
}

#[derive(Debug)]
struct Point<T>{
    x: T,
    y: T,
}

// Nesse exemplo, os valores de qualquer tipo recebem esse método
impl<T> Point<T> {
    fn x(&self) -> &T{
        &self.x
    }
}

// Nesse exemplo, somente os valores do tipo f32 recebem esse método
impl Point<f32> {

    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}
```
- Nesse exemplo, o método `x` aplica a qualquer tipo de dados;
- Porém o método `distance_from_origin` só aplica somente aos valores que sejam do tipo de `f32`
- Também é importante destacar que a implementação `impl` para os genéricos não são automáticos, e precisamos também 

Isso demonstra que podemos usar método para implementar comportamento específico.


Também podemos fazer desse jeito:
```Rust
fn main(){

    let p1 = Point {x: 10, y: 20};
    let p2 = Point {x: "exemplo", y: "a"};

    let p3 = p1.mixup(p2);

    println!("{:?}", p3);

}

#[derive(Debug)]
struct Point<X1, X2>{
    x: X1,
    y: X2,
}

impl<X1, Y1> Point<X1, Y1> {
    fn mixup<X2, Y2>(self, other: Point<X2, Y2>) -> Point<X1, Y2> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}
```
- No exemplo acima, a gente pode misturar entre diferentes tipos