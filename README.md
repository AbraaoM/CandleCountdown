# Candle Countdown

## Introdução
  Pessoas que realizam operações financeira em mercados financeiros muitas vezes utilizam gráficos de preços para visualizar o movimento do mercado e embasar suas decisões, um tipo de gráfico comum para este fim é o gráfico de candles, esse tipo de gráfico gera uma vela com indicações de preços de abertura, fechamento, máxima e mínima em um determinado período de tempo, terminado esse período uma nova vela começa a ser formada. O intuito deste trabalho é criar um cronômetro que indique a quantidade de tempo restante para o fechamento da vela corrente, oferecendo ao trader mais uma ferramenta que facilita a compreensão do gráfico.

## Metodologia
  A função padrão OnCalculate possui entradas padronizadas que possibilitam a obtenção de algumas informações do ativo negociado uma delas é a informação de hora de abertura do candle, utilizando essa informação juntamente com a do período corrente no gráfico e o horário atual a contagem regressiva é calculada seguindo a seguinte equação:
  HR = HAb - HAt + P
  HR = Horário instantâneo para a contagem regressiva;
  HAb = Horário de abertura do candle corrente;
  HAt = Horário atual (último recebido pelo servidor);
  P = Período corrente no gráfico em que o indicador está aplicado.

## Resultados e discuções
  ### v. 01.00
  Nesta versão a exibição é feita por meio da função Comment, ou seja, o contador aparecerá no canto superior esquerdo do gráfico.

![Ilustração versão 01.00](https://github.com/AbraaoM/CandleCountdown/blob/master/images/v0.png)

  Neste tipo de visualização o contador fica discreto e não interfere leitura do gráfico, embora seja de difícil leitura pelo tamanho da fonte padrão do método de exibição utilizado.

  ### v. 01.01
  Adicionada exibição utilizando objetos. Foi criado um objeto do tipo label e ancorado no topo superior direito, é possível editar o tamanho da fonte e a cor. Também foi adicionada a possibilidade de escolher entre os tipos de exibição, “comment”  ou “Big Number”.

![Ilustração versão 01.01](https://github.com/AbraaoM/CandleCountdown/blob/master/images/v1.png)

  Neste tipo de exibição o usuário pode escolher a melhor forma de visualização do contador em termos de tamanho, cor e estilo da fonte.

  ### v. 01.02
  Adicionada a exibição ainda por meio de objetos, mas agora com um objeto do tipo text, que é criado e movido de forma a seguir o preço de fechamento do último tick.

![Ilustração versão 01.02](https://github.com/AbraaoM/CandleCountdown/blob/master/images/v2.gif)

  É recomendável utilizar neste modo “On Price” uma fonte menor do que no modo “Big Number”.

### v. 02.00
- Alteração da estratégia de implementação, agora utilizando programação orientada a objetos;
- Extração do funcionamento do relógio para uma biblioteca, que pode ser utilizada separadamente;
- Correção de bugs.

#### **Métodos da biblioteca:**

**GetCountdownValue**  - Retorna o valor da contagem regressiva em uma string;

**CountdownUpdate** - Atualiza a variável interna que armazena o valor da contagem regressiva e atualiza os tipos de exibição que estão sendo utilizados ("comment", "big number" e "on price");

**CreateBigNumber** - Cria e configura a label do big number;

**CreateComment** - Inicializa a exibição do tipo comment

**CreateOnPrice** - Cria e configura a label do On Price





  
