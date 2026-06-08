use serde::{Serialize, Deserialize};
#[derive(PartialEq, Debug, Clone, Serialize, Deserialize)]
pub struct Aluno {
    pub nome: String,
    pub notas: Vec<u8>
}
