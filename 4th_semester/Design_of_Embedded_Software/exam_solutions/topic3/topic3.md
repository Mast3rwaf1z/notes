# topic3
Protocol implementation specifics:

the protocol was implemented as a class either generating the frame or taking an existing frame in string form and converting it

an arduino running the protocol can be communicated with over tty using the following command:

`echo "2|0|16|34|16|35|16|48|16|34|16|35|16|48|16|34|16|35|16|48|16|34|16|35|16|48|16|34|0|3|" >> /dev/ttyACM1`

## EBNF
```ebnf
symbol = "|"
digit = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
alphabetic character = "A" | "B" | "C" | "D" | "E" | "F"
frame = (digit | alphabetic character), (digit | alphabetic character), {|, (digit | alphabetic character), (digit | alphabetic character)}
rule = "02", "03", "10"
```
## 