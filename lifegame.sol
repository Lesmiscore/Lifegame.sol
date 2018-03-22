pragma solidity ^0.4.17;

contract CGoL {
    mapping(int16 => mapping(int16 => int8)) private states;
    mapping(int16 => mapping(int16 => int8)) private tmpStates;
    int16 constant public width = 16;
    int16 constant public height = 16;
    function CGoL() public{
        for (int16 x = 0; x < width; x++) {
            for (int16 y = 0; y < height; y++) {
                states[x][y] = 0;
            }
        }
    }
    function setState(int16 x,int16 y,bool state) public {
        states[x % width][y % height] = int8(state ? 1 : 0);
    }
    function getState(int16 x,int16 y,uint64 dummy) public constant returns (bool) {
        return states[(x+width) % width][(y+height) % height] != 0;
    }
    function next() public {
        for (int16 x = 0; x < width; x++) {
            for (int16 y = 0; y < height; y++) {
                int8 value = 0;
                for(int16 xd = x-1; xd<=x+1; xd++) {
                    for(int16 yd = y-1; yd<=y+1; yd++) {
                        value += states[x][y];
                    }
                }
                tmpStates[x][y] = int8((value >= 5)?1:0);
            }
        }
        for (int16 x1 = 0; x1 < width; x1++) {
            for (int16 y1 = 0; y1 < height; y1++) {
                states[x1][y1] = tmpStates[x1][y1];
            }
        }
    }
}
