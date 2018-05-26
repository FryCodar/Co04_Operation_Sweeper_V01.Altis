If(!hasInterface) exitWith {};
#include "msot_components.hpp"
#include "..\msot_briefing.hpp"


If(!(_briefing_text_situation isEqualTo ""))then
{
  player createDiaryRecord ["Diary", ["SITUATION", _briefing_text_situation]];
};
If(!(_briefing_text_order isEqualTo ""))then
{
  player createDiaryRecord ["Diary", ["AUFTRAG", _briefing_text_order]];
};
If(!(_briefing_text_execution isEqualTo ""))then
{
  player createDiaryRecord ["Diary", ["DURCHFÜHRUNG", _briefing_text_execution]];
};

If(!(_briefing_text_support isEqualTo ""))then
{
  player createDiaryRecord ["Diary", ["UNTERSTÜTZUNG", _briefing_text_support]];
};
