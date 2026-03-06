# Godot 4 Quick Start Project

Este é um projeto simples criado para servir de introdução ao **Godot Engine 4**.

## 🛠️ Requisitos

Para rodar este projeto, você precisará ter o Godot 4 instalado na sua máquina.
*   **Download:** [Baixe o Godot Engine 4.x](https://godotengine.org/download)

Se você estiver em distros Linux baseadas em Debian/Ubuntu, pode instalar via terminal (versão mais antiga) ou usar Flatpak (recomendado):
```bash
flatpak install flathub org.godotengine.Godot
```

## 🚀 Como Abrir e Rodar o Projeto

1.  **Abra o Godot Engine.** A tela do "Project Manager" (Gerenciador de Projetos) será exibida.
2.  Clique no botão **"Import"** (Importar) localizado no lado direito da tela.
3.  No campo "Project Path", navegue até a pasta deste projeto (`/home/felipe/desenv/persona/testegodot`) e selecione o arquivo `project.godot`.
4.  Clique no botão **"Import & Edit"** (Importar e Editar). O editor do Godot será aberto e carregará o projeto.
5.  Para rodar o jogo, pressione a tecla **`F5`** no seu teclado. Alternativamente, você pode clicar no botão **"Play"** (ícone de um triângulo parecido com "▶️") no canto superior direito da tela do editor.

## 🤖 Desenvolvimento Auxiliado por IA (Google Antigravity)

Este projeto foi construído e pode ser continuado utilizando o **Google Antigravity**, um agente editor de código focado em desenvolvimento de software auxiliado por Inteligência Artificial.

**Como usar o Antigravity com o Godot:**
1. Abra a interface de chat do Antigravity acoplada ao repositório ou diretório do projeto.
2. O agente consegue ler todos os arquivos `.gd` (GDScript) e `.tscn` (Cenas) automaticamente.
3. Peça em linguagem natural para adicionar novos comportamentos de inimigos, sistemas de partículas, ou menus. O agente irá propor as modificações arquiteturais e implementá-las diretamente nos arquivos.
4. Para melhores resultados ao pedir uma mecânica nova, sempre mencione as classes e grupos já existentes (ex: `Player`, `Enemy`, grupo `enemies`), para o agente não recriar a roda.

## 📂 Estrutura do Projeto

*   `project.godot`: Arquivo de configuração que identifica a pasta como um projeto Godot.
*   `main.tscn`: A cena principal (`Scene`) contendo uma mensagem de texto simples.
*   `main.gd`: O script (`GDScript`) associado à cena principal, responsável pela rotação do objeto e a mensagem de inicialização no terminal do editor.
*   `icon.svg`: Ícone padrão do projeto.

---
Divirta-se explorando o Godot!
