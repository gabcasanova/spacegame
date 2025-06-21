# 🎮 Gameplay

## 🚀 Espaçonave
Na visão interna da espaçonave, o jogo funciona basicamente como um point-and-click adventure game extremamente simples. Você, o capitão, está dentro da espaçonave no cockpit principal, rodeado pelos seus oficiais. Você pode se mover e visitar diferentes partes da nave. Essa visão funcionará basicamente como um menu interativo de estatísticas do jogo.

### Estatísticas da Espaçonave
Essas são as variáveis relacionadas à espaçonave, que será do interesse do jogador manter equilibradas.
* **💸 Dinheiro:** Necessário para construir, comprar itens e negociar tratados. O jogador precisará gerenciar essa quantia cuidadosamente.
* **⚡ Energia:** Essencial para a navegação espacial e aterrissagem. Essa energia pode ser coletada ou comprada.
* **💂‍♂️ Soldados:** A nave começa com um número definido de soldados. Esse número diminui conforme bases militares são criadas e batalhas ocorrem.
* **🧳 Inventário:** A espaçonave possui um inventário para o transporte de recursos entre os planetas.

### Oficiais
Os oficiais fornecem ao jogador sugestões e dicas de como proceder, funcionando de forma semelhante aos "advisors" do SimCity 3000. O diálogo deles será contextualmente sensível, mudando de acordo com a seção do jogo em que o jogador está e seu desempenho no mapa atual (se a nave estiver aterrissada em um planeta). Eles também ajudam no desenvolvimento do mundo, fornecendo mais contexto da lore e avançando a história.

#### Oficial de Defesa
O oficial de defesa é o chefe militar da nave. Ele sugere ações militares ao capitão, como:
* Contratar novos soldados, caso a frota esteja reduzida.
* Recomendar a criação de mais bases militares no planeta ou a realização de ataques militares.

*A perspectiva do oficial de defesa tende a ser mais autoritária.*

#### Oficial de Comunicações
O oficial de comunicações é responsável de manter o contato do jogador com o planeta na qual ele está tentando manter contato.
* **Caso o jogador entre na órbita de um planeta**, ele precisará pedir ao oficial de comunicações se comunicar com o planeta e pedir para aterrissar. Se isso não for feito, guerra espacial imediata acontecerá pois será considerada uma invasão. A autorização ou não dependerá da personalidade da raça alienígena.

## 🌎 Planeta

### Variáveis
* **Recursos:** Cada planeta possui dois recursos específicos gerados aleatoriamente. O jogador inicialmente não saberá quais recursos tornam o planeta único.
* **Personalidade da Raça Alienígena:** A raça alienígena terá características que farão com que o jogador ajuste seu comportamento.
  * *Isolacionistas:* Não estabelecem relações diplomáticas ou comerciais com o jogador.
  * *Moderados:* Realizam trocas comerciais e diplomáticas com o jogador.
  * *Mesquinhos:* Realizam trocas comerciais com o jogador, mas sempre com um preço 25% maior do que o padrão.
* **Militarização:** O nível de militarização da raça alienígena será definido com base no nível de militarização do jogador no primeiro contato.
  * *Pacíficos:* Mais fracos que o jogador.
  * *Equivalentes:* Mesma força que o jogador.
  * *Guerreiros:* Mais fortes que o jogador.

### Construções
* **Diplomacia**
  * **Posto Diplomático:** Essa construção estabelece o primeiro relacionamento entre o jogador e a raça alienígena do planeta. É a única construção disponível ao aterrissar em um novo planeta. Quando construída, uma janela aparece com a mensagem: "Você gostaria de estabelecer relações com este planeta?"