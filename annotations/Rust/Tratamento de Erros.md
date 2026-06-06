[[rust]]

Existem duas formas de tratar os erros:
- Recuperáveis como o `Result` e `Expect`
- Irrecuperáveis como o macro `panic!`

É importante saber quando usar `panic!` ou fazer tratamento de erros recuperáveis.

Geralmente é recomendável usar `panic!` nas seguintes situações:
- Quando estamos fazendo um protótipo ou o código ainda está em desenvolvimento. Os panics podem atuar como o placeholder.
- Também podemos usar `panic!` para os testes que precisam ser fail fast. Ou seja, se um teste falhar, o suíte inteiro deverá falhar.
- Quando estamos tratando das situações impossíveis de acontecer ou a gente tem garantia 100% de que nunca haverá variante de `Err`. 
- Ou quando o código está no estado ruim onde as suposições, contratos ou garantias são invalidados e é melhor crashar para não "espalhar" os problemas para o programa inteiro.
	- Ou seja, se chegar ao ponto onde é prejudicial se continuar, especialmente se tiver bugs, é melhor acionar `panic!`.
	- Como tentar acessar memória fora dos limites e assim por diante.

Mas é recomendável tratar os erros esperados como o parser recebendo os dados mal formatados ou erros de requisições habituais.
# Erros irrecuperáveis

Há duas formas de causar esse tipo de erro irrecuperável: intencional e causada pelo próprio código.
- Os intencionais são aqueles causadas pelo próprio macro `panic!`, ou seja, nós podemos intencionalmente incluir `panic!` no código para que o programa entre em pânico.
- Aqueles que são causados pelo próprio código geralmente são por causa dos index não válidos (out of bound) e da divisão por zero. Ou seja, o programa entrará em pânico automaticamente caso um código tente acessar a índice que não existe ou fazer operações impossíveis

Quando o programa entra em pânico, podemos também fazer um backtrace para investigar a fundo onde o problema ocorreu. Inclusive por padrão, o programa fará um unwind que basicamente faz uma limpeza do programa até reverter para seu estado original.
- Para isso, devemos usar `RUST_BACKTRACE` na nossa variável de ambiente, e basicamente vai listar todas as funções até encontrar o problema onde originou, de modo semelhante em alguns linguagens de programação como Python.



# Erros recuperáveis

Os erros recuperáveis geralmente envolvem com o uso do `Result`, `Expect` e `Unwrap`

O `Result <T, E>` é um tipo de Enum que tem duas variantes: `Ok(T)` e `Err(E)`.
- A notação `<T, E>` significa que recebe 2 variáveis do tipo genérico (aceita qualquer tipo de dados)
- Também significa que "pode ter sucesso ou ter erro", onde `T` é o tipo de valor a ser retornado caso tiver sucesso, e `E` representa o tipo de erro retornado em caso de falha.

```rust
use std::fs::File;

fn main() {
    println!("Hello, world!");

    let file_example_result = File::open("hello.txt");
    
    let file_example: File = match file_example_result {
        Ok(file) => file,
        Err(error) => panic!("There was some problem opening this file:{}", error)
        
    };

    println!("{:?}",file_example);
}

```


Também podemos usar vários matchs (ainda que possa prejudicar a legibilidade do código) para destrinchar diferentes tipos de erros:
```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    println!("Hello, world!");

    let file_example_result = File::open("hello.txt");
    
    let file_example: File = match file_example_result {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("There was some problem while creating file: {e:?}")
            },
            _ => {
                panic!("There was some problem opening this file: {error:?}")
            }
        }
        
    };

    println!("{:?}",file_example);
}

```
- Usamos o módulo `ErrorKind` que tem variantes diferentes de erros que podem surgir no Rust, como `ErrorKind::NotFound`.

## Unwrap
Também podemos usar um `Unwrap` que pode retornar um `Result` com variante `Ok` e `Err`:
- Caso retorne `Ok`, passará o valor normalmente
- Caso retorne `Err`, o programa irá acionar `panic!`

```Rust

fn main() {
    println!("Hello, world!");

    let file_example_result = File::open("hello_world.txt").unwrap();

    println!("{:?}", file_example_result);
}
```

## Expect
O método `expect` é forma mais profissional de usar o `unwrap`, pois permite escrever a mensagem de erro personalizado, além de exibir uma mensagem de erro, invés de usar a mensagem padrão.
```Rust
fn main() {
    println!("Hello, world!");

    let file_example_result = File::open("hello_world.txt").expect("Ops, arquivo não encontrado!");

    println!("{:?}", file_example_result);
}
```
Resultado:
```
Ops, arquivo não encontrado!: Os { code: 2, kind: NotFound, message: "O sistema não pode encontrar o arquivo especificado." }
```

## Propagar os Erros 

Invés de tratar os próprios erros dentro de uma função, a gente pode propagar os erros e devolver o erro ao código chamador. Ou seja, podemos passar o retorno de uma função algo como `Result <T, io::Error>` para o código que chamou.

Seria algo assim:
```Rust
fn main() {
    let result = read_file_txt();
    println!("{:?}", result)

}

fn read_file_txt() -> Result<String, io::Error> {
    let username_file_result = File::open("hello.txt");

    let mut username_file = match username_file_result{
        Ok(file) => file,
        Err(e) => return Err(e),
    };

    let mut username = String::new();

    match username_file.read_to_string(&mut username) {
        Ok(_) => Ok(username),
        Err(e) => Err(e), 
    }    
}
```
- No exemplo acima, temos um return usando `Result`, deixando o chamador decida o que fazer com o `Result`, podendo criar um novo arquivo, usar o valor padrão ou tentar novamente e assim por diante.
- Ou seja, na prática, a função intermediária `read_file_txt` só repassa o que deu errado para o chamador principal.

Também estamos dizendo que a possibilidade de erro faz parte do tipo no Rust, diferentemente dos erros em outras linguagens como Python onde erro é tratado como exceção.

## Operador ?

O operador `?` basicamente substitui esse tipo de `match`:
```Rust
match something {
    Ok(v) => v,
    Err(e) => return Err(e),
}
```

Ou seja, ao usar nesse código acima, vira algo assim mais sucinto:
```Rust
fn read_file_txt() -> Result<String, io::Error> {
    let mut username_file = File::open("hello.txt")?;

    let mut username = String::new();

    username_file.read_to_string(&mut username)?;

     Ok(username)

}
```
- Na prática, isso faz a mesma coisa que `match` faz para propagar os erros e é uma das funcionalidades mais utilizadas no Rust.

Mas é importante lembrar que o `match` e o operador `?` não são as mesmas coisas na prática
- O match não faz uma conversão de erro automático, e precisaria alinhar certinho os tipos de erros 
- Mas o operador converte os erros automaticamente usando o traço `From` que é a conversão de um tipo de erro para outro tipo de erro.

Também podemos encadear o operador com os métodos na mesma linha:
```Rust
fn read_file_txt() -> Result<String, io::Error> {
    let mut username = String::new();
    File::open("hello.txt")?
    .read_to_string(&mut username)?;

     Ok(username)

}
```
- No exemplo acima, nós movemos o `let mut username` para primeira linha da função;
- Então, a gente faz encadeamento ao juntar `File::open("hello.txt)?` com o método `read_to_string()`
- Isso torna em algo muito mais sucinto e mais ergonômica de escrever

É importante lembrar que o operador `?` sempre só pode ser usado com as funções com retorno `Result` ou `Option` ou outros tipos com traço `FromResidual`.

# Sistema de tipos para validação

Os tipos são essenciais no Rust pois eles também atuam como validação e evita também as inconsistências no código.
- Ou seja também serve para representar as regras, garantias e estados válidos
- Na prática, o Rust faz com que os dados inválidos sejam impossíveis de acontecer

Ou seja, criamos um tipo que representa somente os estados válidos, atuando como contrato, regra e garantia.
- Também permite fazer com que não seja necessário validar cada código, o que pode gerar problemas como esquecimento ou inconsistência. Dessa forma, ao considerar apenas os estados já validados, não há necessidade de validar em cada parte de código que os utilizam.
- A validação também fica mais centralizada, e os tipos passam a representar os significados semânticos























