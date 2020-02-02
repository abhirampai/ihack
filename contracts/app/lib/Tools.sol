pragma solidity 0.4.21;
library Tools {

    function isEmptyString(string memory str) pure public returns (bool) {
        bytes memory emptyTest = bytes(str);
        return (emptyTest.length == 0);
    }

}
