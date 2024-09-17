avail(1..150, DAY) :- x(_, DAY, _, _, _).
new_reg(ID, DAY, TS, N, PrID) :- new_reg(ID, TS, N, PrID), avail(_, DAY).
block(TS_MIN) :- #min{TS: new_reg(ID, D, TS, P, PrID); TS: x(ID, D, TS, PrID, P), exam_new(ID, P, NumTS)} = TS_MIN.
block(ID, P) :- x(ID, D, TS, P, PrID), block(TS_MIN), TS < TS_MIN.
{y(ID, D, TS, PrID, P) : avail(TS, D), TS >= RequiredTS} = 1 :- new_reg(ID, D, RequiredTS, P, PrID).
{y(ID, D, TS_N, PrID, 0) : avail(TS_N, D), TS_N >= TS} = 1 :- x(ID, D, TS, PrID, 0), not block(ID, 0).
{y(ID, D, START, PrID, P+1) : avail(START,D), START >= TS+NumTS} = 1 :- y(ID, D, TS, PrID, P), exam(PrID, P, NumTS), P >= 0, P < 3, not block(ID, P).
{y(ID, D, START, PrID, P+1) : avail(START,D), START >= TS+NumTS} = 1 :- y(ID, D, TS, PrID, P), exam_new(ID, P, NumTS), P >= 0, P < 3.
y(ID, D, TS, PrID, P) :- x(ID, D, TS, PrID, P), block(ID, P), not exam_new(ID, _, _).
:- y(ID, D, TS_N, _, P), x(ID, D, TS_O, _, P), TS_N < TS_O. 
timeAnamnesis(ID, TS..TS+NumTS-1) :- y(ID, D, TS, PrID, 0), exam(PrID, 0, NumTS).
:- #count{ID: timeAnamnesis(ID, TS)} > 2, avail(TS,D).
timeOccupation(ID, D, TS, END-1, PrID) :- y(ID, D, TS, PrID, 1), y(ID, D, END, PrID, 3).
res(ID, D, TS..END,0) :- timeOccupation(ID, D, TS, END, PrID), required_chair(PrID).
res(ID, D, TS..TS+NumTS-1,1) :- y(ID, D, TS, PrID, 3), exam(PrID, 3, NumTS), required_chair(PrID).
res(ID, D, TS..END+NumTS-1,1) :- timeOccupation(ID, D, TS, END, PrID), exam(PrID, 3, NumTS), not required_chair(PrID).
:- #count{ID: ytomograph(T, ID, D), y(ID, D, _, PrID, _)} > N, limit(PrID, N), tomograph(T,_).
1 {ychair(C, ID, D) : chair(C, _)} 1 :- y(ID, D, _, PrID, _), required_chair(PrID).
1 {ytomograph(T, ID, D) : tomograph(T, _)} 1 :- y(ID, D, _, PrID, _).
:- ychair(C, ID, D), ytomograph(T, ID, D), chair(C, R1), tomograph(T, R2), R1 != R2.
ychair(C, ID, D, TS) :- ychair(C, ID, D), res(ID, D, TS, 0).
ytomograph(T, ID, D, TS) :- ytomograph(T, ID, D), res(ID, D, TS, 1).
:- #count{ID: ytomograph(T, ID, D, TS)} > 1, tomograph(T,_), avail(TS,D).
:- #count{ID : ychair(C, ID, D, TS)} > 1, chair(C,_), avail(TS,D).
:~ y(ID, D, TS, _, P), new_reg(ID, D, RequiredTS, _, P). [TS-RequiredTS@6, ID]
:~ y(ID, D, TS_N, _, P), x(ID, D, TS_O, _, P). [TS_N-TS_O@5, ID]
:~ res(ID, D, TS, _), TS > 120. [1@3, ID, TS]
:~ not ytomograph(T, ID, _, _), tomograph(T, ID, _, _). [1@2, ID]
:~ not ychair(C, ID, _, _), chair(C, ID, _, _). [1@2,ID]

#show y/5.