

# 📏 Projeto: Contador de Período em Milissegundos

## 📝 Descrição

Este projeto implementa um **contador de período** que mede o tempo em milissegundos entre duas bordas de subida de um sinal de clock, desenvolvido em **SystemVerilog**. O repositório inclui a **implementação do código**, um **testbench** para validar o contador, um arquivo de **vetores de teste** e um **diagrama ASM** para auxiliar na compreensão do funcionamento.

## 📂 Estrutura do Repositório

- **src/**: Contém o código fonte e o testbench
  - `contador_de_periodos.sv`: Código do contador de períodos
  - `testbench_contador_de_periodos.sv`: Testbench para validação do contador

- **vetores_teste/**: Contém o arquivo de vetores de teste
  - `testvectors.txt`: Arquivo com valores esperados para os testes

- **diagrama_asm/**: Contém o diagrama ASM
  - `diagrama_asm.png`: Diagrama ASM do contador de períodos

- **README.md**: Documentação do projeto

## ⚙️ Funcionalidade

O módulo **contador_de_periodos** realiza a contagem do intervalo de tempo entre duas bordas de subida do sinal de clock. As principais funcionalidades são:

- ⏱️ Contagem precisa em milissegundos entre bordas de subida.
- 📤 Saída do valor da contagem.
- 🔄 Reset assíncrono para reinicializar o contador.

## 🧪 Testbench

O **testbench** (`testbench_contador_de_periodos.sv`) valida o funcionamento do contador comparando os resultados gerados com os valores esperados, que estão no arquivo `testvectors.txt`.

### Funcionamento:

1. O testbench lê os valores do arquivo de vetores e compara com as saídas do contador.
2. Permite pequenas variações nos resultados devido às aproximações da simulação.

## 🖼️ Diagrama ASM

O **diagrama ASM** (`diagrama_asm.png`), localizado na pasta `diagrama_asm/`, ilustra o funcionamento interno do contador, mostrando os estados e as transições.

## 📜 Requisitos

- Ferramenta de simulação que suporte **SystemVerilog** 
- Certifique-se de que todos os arquivos estão nos diretórios corretos para execução.

