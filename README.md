<div align="center">
<img src="https://github.com/AdryanneKelly/ipoker/blob/main/assets/images/logo_ipoker.png?raw=true" height='150px'/>
  
</div>

# iPoker
| ![Screenshot_1732036161](https://github.com/user-attachments/assets/86879ad9-47c5-4602-ba80-74223fd1f2bb) | ![Screenshot_1732036154](https://github.com/user-attachments/assets/c2f51a83-3e29-4739-86be-bef4fd9ba496) |  ![Screenshot_1732036760](https://github.com/user-attachments/assets/cccd5ffc-64c9-42b4-9afb-ce6c18c95e42) | ![Screenshot_1732036767](https://github.com/user-attachments/assets/731aebe9-fc8c-4b7d-9af5-c2840fa45120) |
| ---  | ---| --- | --- |
|![Screenshot_1732036905](https://github.com/user-attachments/assets/a6c9e1d6-39ac-4ebd-acde-46e46af9d7b2) | ![Screenshot_1732036971](https://github.com/user-attachments/assets/f23baa45-1b79-4861-b5b9-4f581c0f2f93) |  ![Screenshot_1732037013](https://github.com/user-attachments/assets/cafe8d0d-f430-4f57-bbd3-f5426eb42346)  | ![Screenshot_1732037260](https://github.com/user-attachments/assets/c7d8a72a-8170-414b-9e7e-cc8a378fde28) | ![Screenshot_1732037282](https://github.com/user-attachments/assets/f387110f-1d18-4090-80bc-aaa41c718bd7)



## Sobre o projeto

Neste projeto decidi por fazer uma solução de modo em que fosse possível criar salas ou entrar nelas, como mostrado nas fotos acima. Quem cria a sala automaticamente se torna moderador dela, e sendo assim tem funções que só ele pode executar como: Adicionar tarefas, pontuar a tarefa com o valor final discutido na votacao, puxar a próxima tarefa e finalizar a votaçao. Já os participantes poderão entrar na sala e poderão votar na tarefa atual mostrada na tela.

## Sobre a estrutura 

Optei por usar Clean Architecture para a estrutura, tentando respeitar também principios do SOLID. Para injecção de dependencias optei pelo GetIt por sua abordagem mais limpa e organizada. Para gerencia de estados optei por usar BLoC, tentando manter também o padrão do mesmo.
Para a base de dados, estou utilizando Firebase, por ser rápido e prático de usar, além de ter atualizações em tempo real (por exemplo, assim que o participante vota o numero escolhido aparece na tela). Utilizei também GoRouter para uma melhor organização de rotas.

## Pendencias

Com o prazo, infelizmente não pude conlcuir algumas coisas, ainda precisava refatorar algumas partes do código para se adequar a estrutura, finalizar os estilos padrões de tela (alem de deixar um tiquinho mais bonito kk) e fazer a parte dos testes.








