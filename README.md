# Sistema de Decisão para Classificação de Filmes

## Descrição

Este projeto tem como objetivo desenvolver uma solução que auxilie os administradores a tomar as melhores decisões quanto à classificação dos títulos que serão exibidos nas sessões diárias em um cinema e aqueles que possivelmente trarão melhor retorno financeiro.

## Ferramentas Utilizadas

- SQL Server Data Tools
- Analysis Services
- Serviços de Integração
- Visual Studio 2022
- SQL Server Management Studio

## Base de Dados

A base de dados a ser utilizada está disponível em: [IMDb Extensive Dataset](https://www.kaggle.com/code/stefanoleone992/imdb-extensive-dataset)

## Etapas do Projeto

1. **Organização das Informações**: As informações serão organizadas em um primeiro estágio em uma base Stage (Sql Server) utilizando a ferramenta Integration Services.

2. **Modelagem Multidimensional**: A partir dos dados carregados na Stage, será realizada a modelagem multidimensional e os dados serão consolidados em uma base DW (Sql Server).

3. **Construção do Cubo**: A ferramenta Analysis Services será utilizada para construir o cubo.

4. **Geração de Painéis**: A ferramenta Power Bi será utilizada para a geração de painéis contendo os indicadores modelados.

## Liberdade para Modelar KPIs

Você terá total liberdade para modelar e sugerir os KPIs que julgar interessantes para auxiliar na tomada de decisões.

## Vídeos de Explicação

- [Vídeo 1](https://www.loom.com/share/61de15b9365e475fb8f5dc68d6ce72c5)
- [Vídeo 2 - Continuação](https://www.loom.com/share/52512c213ef34a3789bcc0d01536cc37)
- [Vídeo 3 - Continuação](https://www.loom.com/share/861954525ddb4f0b90b6223c3d645b49)
- [Vídeo 4 - Continuação](https://www.loom.com/share/526880ee4c4a4e2daaa13e4957130531)

## Resultado Esperado

Espera-se que, ao final do processo, seja entregue uma solução que auxilie na tomada de decisões sobre a classificação dos títulos a serem exibidos nas sessões diárias de um cinema, bem como aqueles que possivelmente trarão o melhor retorno financeiro.
