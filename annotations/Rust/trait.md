[[rust]]

Os traits são um pouco parecido com a ideia de classes, interface e do duck typing  no Python, mas implementa de jeito diferente, pois não há herança de verdade.

No Python, como é programação orientada a objeto, temos as classes que podem herdar.
- Ou seja um classe de cachorro herda do classe de animal e herda os comportamentos da classe de animal.
- Isso pode ser problemático conforme o sistema vai se expandindo e alguns comportamentos podem não aplicar exatamente às suas classes filhas (ex: temos cachorro que não late, ou que temos aves que não voam)
- A herança excessiva pode tornar acoplamento forte e mais difícil de manter e escalar conforme o tempo.
- No Python, dizemos que "herda o comportamento"
- Invés de POO mais tradicional, a gente também usa o Duck Typing que é mais próximo dos Traits em Rust, pois envolve mais no próprio comportamento do que ser objeto.
	- Mas diferentemente do Rust, caso tente implemente os comportamentos em classes inválidas podem dar erros somente em RUNTIME. Ex: implementar o comportamento de calcular a área para classe de cachorro).
	- Por outro lado, como o Rust tem contrato mais explícito, nem complia caso tiver incompatibilidade entre os Structs e traits.

Mas no Rust, não temos herança, e é tratado de forma diferente. Invés de herança, a gente faz a implementação da composição. 
- Ou seja, invés de considerar um cachorro como animal, o cachorro tem características de animal.
- Dessa forma, os structs só recebem os comportamentos, invés de herdar de uma classe.
- No Rust, dizemos que "implementa o contrato/comportamento"


Os traits são úteis pois permite compartilhar as propriedades e comportamentos em comuns para os tipos de dados como Struct e Enum.

Podemos criar uma Trait como nesse exemplo:
```Rust
trait Veiculo {
    fn andar(&self);
}
```
- No exemplo acima, queremos criar uma Trait `Veiculo` e criamos um método `andar` para dar um comportamento a essa trait. Ou seja é o que um traço deveria se comportar.
- Também seria possível criar vários comportamentos/assinaturas diferentes para uma trait

E também podemos implementar essa trait nos Structs, e aí é onde devemos detalhar a implementação da trait e seus métodos:
```Rust
struct Carro {
}

struct Moto {
}

impl Veiculo for Carro {
    fn andar(&self){
        println!("Carro andou");
    }
}

impl Veiculo for Moto {
    fn andar(&self){
        println!("Moto andou");
    }
}
```
- No exemplo acima, como a trait foi implementada para os dois struct (Carro e Moto), devemos também definir o método derivado dessa trait (`andar`).
- Note que caso deixe de implementar o método requerido pela Trait, pode dar erro durante a compliação como no exemplo abaixo:
```Rust
impl Veiculo for Moto {
}

```

```Rust
   |
19 | impl Veiculo for Moto {
   | ^^^^^^^^^^^^^^^^^^^^^ missing `andar` in implementation
...
23 |     fn andar(&self);
   |     ---------------- `andar` from trait
```
- No erro acima, o compliador do Rust aponta que o struct `Moto` deveria ter método `andar`

Podemos usar os métodos implementados para os Stucts `Moto` e `Carro`:
```Rust
fn main() {
    let carro = Carro {};
    let moto = Moto {};
    carro.andar();
    moto.andar();
}
```

# Implementação Padrão

Também podemos implementar um comportamento padrão para alguns métodos de uma trait. Invés de dizer que o carro andou ou a moto andou, podemos escrever assim:
```Rust
fn main() {
    let carro = Carro {};
    let moto = Moto {};
    carro.andar();
    moto.andar();
}


struct Carro {
}
struct Moto {
}

impl Veiculo for Carro {
}

impl Veiculo for Moto {
}

trait Veiculo {
    fn andar(&self){
        println!("Veiculo andou");
    }
}

```
- Nesse exemplo, o programa imprime assim: 
```
Veiculo andou
Veiculo andou
```
- Caso não especifique nada nas implementações para os Structs, o comportamento padrão da Trait irá imprimir `Veiculo andou`.
- Também, é possível sobrescrever o comportamento caso escreva algo nos métodos das respectivas implementações dos Structs.

# Uso das Traits em Funções/Métodos

Também é possível implementar as Traits dentro de uma função, atuando como parâmetro a ser preenchido.

Um dos principais usos desse uso é exatamente delimitar, via trait, quais tipos que podem ir nos parâmetros em uma função/método.

## Trait Bound

Também usamos o `Trait Bound` para limitar quais traços que os tipos a serem incluídos deveriam estar como parâmetro. Isso é feito em combinação com os generics.

```Rust
fn tipo_veiculo(veiculo: &impl Veiculo) {
    println!("Tipo de veiculo: {}", std::any::type_name_of_val(veiculo));
}


// Faz a mesma coisa também que o de cima, só que usando Generics
fn tipo_veiculo2<T: Veiculo>(veiculo: &T) {
    println!("Tipo de veiculo: {}", std::any::type_name_of_val(veiculo));
}
```
- O segundo basicamente é açúcar sintático, em que usamos um generic invés do primeiro exemplo acima, em combinação com as traits.
- No primeiro, com `impl Trait`, entendemos que essa função aceita qualquer coisa que tenha a trait `Veiculo`. 
- Porém no segundo, entendemos que precisamos reutilizar o `T` e que só admite os valores de diversos parâmetros do **mesmo tipo**.


```Rust
fn main(){
	dois_veiculos_diferente(&carro, &moto); // pode ser de diferente tipo 
}

fn dois_veiculos_diferente(a: &impl Veiculo, b: &impl Veiculo){
    println!("Dois veiculos: {} e {}", std::any::type_name_of_val(a), std::any::type_name_of_val(b));
}

```
- No exemplo da função `dois_veiculos_diferente`, `a` e `b` podem ser de diferentes tipos.


```Rust
fn main(){
	dois_veiculos(&carro, &carro2); // deve ser do mesmo tipo (carro)
}

fn dois_veiculos<T: Veiculo>(a: &T, b: &T){
    println!("Dois veiculos: {} e {}", std::any::type_name_of_val(a), std::any::type_name_of_val(b));
}
	
```
- Nesse exemplo, ao usar o mesmo generic `T`, estamos dizendo que `a` e `b` devem ser do mesmo tipo concreto.

Também há duas formas diferentes de fazer com 2 ou mais traits:
```Rust
fn veiculo_com_quatro_rodas(veiculo: &(impl Veiculo + QuatroRodas)) {
    println!("Esse veiculo do tipo {} tem 4 rodas", std::any::type_name_of_val(veiculo));
}

fn veiculo_com_duas_rodas(veiculo: &(impl Veiculo + DuasRodas)) {
    println!("Esse veiculo do tipo {} tem 2 rodas", std::any::type_name_of_val(veiculo));
}

```
- Assim como nos exemplos anteriores, o uso do `impl trait` significa que qualquer tipo pode estar no `veiculo` 

Há outra forma de se fazer usando generic (ou usando sintatic sugar)
```Rust
fn veiculo_com_quatro_rodas2<T: Veiculo + QuatroRodas>(veiculo: &T) {
    println!("Esse veiculo do tipo {} tem 4 rodas", std::any::type_name_of_val(veiculo));
}

fn veiculo_com_duas_rodas2<T: Veiculo + DuasRodas>(veiculo: &T) {
    println!("Esse veiculo do tipo {} tem 2 rodas", std::any::type_name_of_val(veiculo));
}

```
- Ao usar generic, estamos dizendo que caso tiver 2 ou mais parâmetros do `T`, ambos devem ser do mesmo tipo.

## Cláusula de Where

Podemos usar a clásula `where` para caso onde precise colocar vários traits bounds para melhorar a legibilidade:
```Rust
fn dois_veiculos_diferentes<T, U>(a: &T, b: &U)
where T: Veiculo, U: Veiculo {
    a.andar();
    b.andar();
}
```
- No exemplo acima, podemos fazer uma combinação de diferentes tipos, ou até mesmo combinar diferentes traits como no exemplo abaixo:
```Rust
fn dois_veiculos_diferentes<T, U>(a: &T, b: &U)
where 
	T: Veiculo + QuatroRodas, 
	U: Veiculo + DuasRodas 
{
    a.andar();
    b.andar();
}
```
- Por essa razão, usamos a cláusula `Where` para tornar o código mais legível.
## Retornando os tipos que usam Traits

Também é possível criar as funções que retornam um valor de um tipo que tenha trait especificada, escrevendo `impl Trait` no retorno
```Rust
fn resumo_veiculo() -> impl Veiculo {
    let carro: Carro = Carro {
        modelo: String::from("Civic"),
        marca: String::from("Honda")
    };
    carro
}
```

Mas é importante enfatizar que a condição de `impl Veiculo` não significa que podemos implementar qualquer tipo dentro de uma função como no exemplo abaixo:
```Rust
fn esta_funcao_nao_funciona(switch: bool) -> impl Veiculo {
    if switch {
        let carro: Carro = Carro {
            modelo: String::from("Civic"),
            marca: String::from("Honda")
        };
        carro
    } else {
        let moto = Moto {};
        moto
    }
}
```
- Nesse exemplo, o compliador fica em dúvida pois não sabe qual tipo exato de retorno, se é do tipo de Carro ou é do tipo de Moto.
- Isso significa que devemos usar ÚNICO **TIPO** de valor, e há um genérico implícito de `T` dentro desta função, e todos os retornos desta função deveria retornar esse tipo de `T`

## Métodos condicionais 

Também podemos implementar condicionalmente

## Implementação Geral (Blanket Implementation)

A ideia do blanket implementation é que podemos acrescentar uma Trait a um Tipo que implemente a trait específica.

Ou seja, seria algo como assim:
```
Quem possui matrícula na Universidade
Então ganha automaticamente o acesso ao refeitório universitário
```
