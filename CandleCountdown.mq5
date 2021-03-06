//+------------------------------------------------------------------+
//|                                                  SimpleClock.mq5 |
//|                                                   Abraão Moreira |
//|                                      abraaol.moreira@outlook.com |
//+------------------------------------------------------------------+
#property copyright "Abraão Moreira"
#property link      "abraaol.moreira@outlook.com"
#property version   "2.00"
#property indicator_chart_window

#include <CandleClock.mqh>

input color in_color = clrGray; //Cor do relógio
input string in_font = "Arial";  //Fonte
input int in_fontSize = 10;  //Tamanho da fonte

input clockStyle swapStyle = comment;  //Tipo de exibição

int offsetX = 100;
int offsetY = 10;

CCandleClock *candleCountdown;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//| Create a label object                                            |
//+------------------------------------------------------------------+
int OnInit() {
  candleCountdown = new CCandleClock;
  return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
  delete candleCountdown;
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
  int x, y;
  ArraySetAsSeries(time, true);
  ArraySetAsSeries(close, true);

  switch(swapStyle) {
  case comment:
    candleCountdown.CreateComment();
    break;
  case onPrice:
    candleCountdown.CreateOnPrice(10,
                                  10,
                                  in_font,
                                  in_fontSize,
                                  in_color);
    break;
  case bigNumber:
    candleCountdown.CreateBigNumber(10,
                                    2,
                                    in_font,
                                    in_fontSize,
                                    in_color);
    break;
  }

  candleCountdown.CountdownUpdate();

  return(rates_total);
}

//+------------------------------------------------------------------+
