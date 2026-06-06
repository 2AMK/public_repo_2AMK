[[rust]]

Os enums são espécies de tipo de dados personalizados no Rust, e representa a ideia de enumerar todos os possíveis valores de um tipo.

Para criar um enum, podemos escrever o seguinte sintaxe:
```Rust
enum UserAction {
    Cancel,
    Open,
    Save,
    SaveAs,
    Close
}
```

Para usar uma instância criada a partir de um enum:
```Rust
fn main() {
    let action = UserAction::Cancel;

    println!("A ação foi {:?}", action);
}

#[derive(Debug)]
enum UserAction {
    Cancel,
    Open,
    Save,
    SaveAs,
    Close
}
```
- Observe que foi utilizado o `derive(debug)` pois não é possível imprimir diretamente o valor de um Enum.
- Também usamos a sintaxe de `::`, o que significa que essa variante "Cancel" pertence a namespace de `UserAction`.

Também podemos criar a função, passando qualquer variantes de um Enum:
```Rust
fn user_action(action: UserAction) {}
```
- No exemplo acima, podemos dizer que a função `user_action` recebe qualquer variante do enum `UserAction`.

```Rust
    user_action(UserAction::Cancel);
    user_action(UserAction::Open);
```

Também podemos incluir os tipos diferentes para os variantes de um Enum:
```Rust
fn main() {
    let action = UserAction::Cancel;

    println!("A ação foi {:?}", action);

    user_action(UserAction::Cancel);
    user_action(UserAction::Open("file.txt".to_string()));
}

#[derive(Debug)]
enum UserAction {
    Cancel,
    Open(String),
    Save(String),
    SaveAs(String),
    Close(String)
}

fn user_action(action: UserAction) {}
```

Também podemos usar uma combinação de tipos diferentes, até mesmo é possível chamar outro Enum
```Rust

enum EscopoAcesso {
    Publico,
    Privado,
    Especifico(String),
}

enum NivelAcesso {
    Admin,
    User(EscopoAcesso),
    Guest
}
```

É importante diferenciar entre Struct e Enum.

Um Struct sempre vai ter campos fixos e obrigatórios
```Rust
struct Usuario {
    nome: String,
    idade: u32,
}
```
- No exemplo acima, isso indica que todos os Usuarios sempre deve ter campo de `Nome e idade`.


Mas para Enum, o Enum pode representar uma lista de valores possíveis que um valor pode assumir
```Rust
enum Mensagem {
    Sair,
    Mover { x: i32, y: i32 },
    Escrever(String),
    MudarCor(i32, i32, i32),
}
```
- No exemplo acima, a instância de Mensagem pode assumir um desses valores, mas **nunca dois ou mais ao mesmo tempo**.
- Por exemplo, a instância só pode assumir o valor de Sair OU o valor de Mover

No Rust, um Enum pode representar:
- estados
- possibilidades
- fluxos
- ausência ou presença
- sucesso/erro

## Option T


O" Option T" pode representar o valor nulo (null) OU valor de qualquer tipo `<T>`:
```Rust
enum Option<T> {
    Some(T),
    None,
}
```
- Isso indica que o valor pode ser `Some(valor)` ou `None`
- Diferentemente de outras linguagens de programação como C e Java, o Rust obriga a tratar os dois casos (Some(T) e None)

```Rust
    let algum_numero: Option<i32> = Some(5);
    let algum_texto: Option<String> = Some("algum texto".to_string());

    let ausente_num: Option<i32> = None;
    let ausente_text: Option<String> = None;
```
- No exemplo acima, o `Option<T>` pode ser um i32 ou String, ou qualquer outros tipos que existam no Rust.

No Rust, o null deve ser tratado de maneira mais explicíta, diferentemente de outras linguagens, como no exemplo:
```Rust
let idade: Option<i32>
```
- Isso significa que esse valor de Idade sempre vai ser em i32, nunca poderá ser um valor nulo
- Nas outras linguagens de programação, o valor específico pode ser em Número ou Nulo. Mas isso não ocorre no Rust, pois o nulo é um tipo definido.

E também não é possível fazer as operações envolvendo o `Option<T>` 
```Rust
let x: i8 = 5;
let y: Option<i8> = Some(5);

let soma = x + y; 
```
- Pois o `Option<i8>` é do tipo diferente, e não pode somar com `i8`
- E também o `Option<i8>` pode representar 2 estados (None ou Some(T))

Em outras linguagens, é possível "misturar os tipos" como em Python:
```Python
idade + 5
```
- Caso o valor da variável idade for `None` isso vai quebrar no Runtime
- Mas no Rust, caso tente misturar entre `Option<T>` e os outros tipos, isso vai quebrar ao tentar compliar

Para `Option<T>`, é necessário tratar de forma diferente usando o `match`:
```Rust
fn main() {
    let idade = Some(20);

    match idade {
        Some(valor) => println!("A idade é de {}", valor),
        None => println!("A idade nao foi informada"),
    }
}
```


## Result
Um result `Result<T>` pode retornar o sucesso ou erro.

Porém o `Option<T>` pode resultar em presença ou ausência dos valores

