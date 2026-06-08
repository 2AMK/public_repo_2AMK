use crate::Aluno;

pub fn cadastrar_aluno(nome: String, nota: u8) -> Aluno {
    // Cadastrar Aluno e Notas
    let mut notas = Vec::new();
    notas.push (nota);

    let aluno = Aluno {
        nome,
        notas,
    };
    aluno
}

pub fn remover_aluno(nome: String, vetor_aluno: &mut Vec<Aluno>) -> &mut Vec<Aluno> {
    // Remover Aluno
    vetor_aluno.retain(|aluno| aluno.nome != nome);
    vetor_aluno
}


pub fn listar_alunos(vetor_aluno: &Vec<Aluno>) {
    // Listar Alunos
    let lista_alunos = vetor_aluno
            .iter()
            .map(|aluno| aluno.nome.clone())
            .collect::<Vec<String>>()
            .join(", ");

    println!("Alunos: {}", lista_alunos);
}

pub fn adicionar_nota(vetor_aluno: &mut Vec<Aluno>, nome_aluno: String, nota: u8) -> &mut Vec<Aluno> {
    let vetor_aluno = vetor_aluno;

    for aluno_escolhido in &mut *vetor_aluno {
        if aluno_escolhido.nome == nome_aluno {
            aluno_escolhido.notas.push(nota);
        }
    }
    vetor_aluno
}

pub fn calcular_media_aluno(vetor_aluno: &Vec<Aluno>, nome_aluno: String) -> Option<f32> {
    // Fazer um lookup dos alunos
    if let Some(aluno) = vetor_aluno.iter().find(|aluno| aluno.nome == nome_aluno) {
        // Calcular as notas
        if aluno.notas.len() == 0 {
            return None;
        }
        
        let soma: f32 = aluno.notas.iter().map(|nota| *nota as f32).sum();
        let media: f32 = soma / aluno.notas.len() as f32;
        Some(media)
    } else {
        None
    }
}

pub fn calcular_media_global(vetor_aluno: &Vec<Aluno>){
    let vetor_nota_global: Vec<u8> = vetor_aluno
        .iter()
        .flat_map(|aluno| aluno.notas.iter().copied())
        .collect();
    
    // Caso não tiver nenhum aluno, deveria barrar

    let soma_global: f32 = vetor_nota_global.iter().map(|nota| *nota as f32).sum();
    let media_global: f32 = soma_global / vetor_nota_global.len() as f32;

    println!("Media Global: {}", media_global);
}

pub fn calcular_situacao_aluno(vetor_aluno: &Vec<Aluno>, nome_aluno: String){
    // Fazer um lookup dos alunos
    if let Some(aluno) = vetor_aluno.iter().find(|aluno| aluno.nome == nome_aluno) {
        // Calcular situacao
        if aluno.notas.len() == 0 {
            println!("Aluno sem notas");
        } else {
            // Pegar a média do aluno
            let media = calcular_media_aluno(vetor_aluno, nome_aluno).unwrap();

            if media >= 6.0 {
                println!("Aprovado");
            } else if media >= 5.0 {
                println!("Recuperacao");
            } else {
                println!("Reprovado");
            }
        }
    }
}
