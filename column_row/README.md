## MainAxisAlignment
start - 시작
end - 끝
center - 가운데 
spaceBetween - 끝과 끝을 기준으로 간격 동일하도록 위젯 배치 
spaceEvenly - 끝과 끝을 비워두고 간격이 동일하도록 위젯 배치
spaceAround - spaceEvenly이지만 양끝의 간격이 반을 차지

## CrossAxisAlignment
start - 시작
end - 끝 
center - 가운데    (기본값)
stretch - 값들이 다 늘어나서 영역을 차지 / 각 위젯의 넓이를 무시하고 강제로 넓이 지정

## mainAxisSize
주축의 크기 / 기본적으로 한 줄을 다 먹음.
min - 최소 
max - 최대

## Expanded / Flexible
Row나 Column에만 사용할 수 있다.!
### Expanded 
남아있는 모든 공간을 해당 위젯이 차지 
여러 개 지정하면 동일한 비율로 나눠서 차지
`flex` 속성을 통해서 비율을 지정할 수 있음 (기본값 : 1)

### Flexible
자신의 영역 중 남아있는 공간을 상위 위젯에 귀속시킴.
여러 개 지정하면 동일한 비율로 나눠서 차지
`flex` 속성을 통해서 비율을 지정할 수 있음 (기본값 : 1)

