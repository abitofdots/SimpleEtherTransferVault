pragma solidity ^0.8.0;

contract SimpleEtherTransfer {
    address public owner;

    constructor() {
        owner = msg.sender; // 컨트랙트를 배포한 사람을 소유자로 설정
    }

    // 컨트랙트로 이더를 받을 수 있게 함
    receive() external payable {}

    // 소유자만 호출할 수 있는 이더 전송 함수
    function transferEther(address payable _to, uint _amount) public {
        require(msg.sender == owner, "Only owner can transfer ether");
        require(address(this).balance >= _amount, "Insufficient balance");

        // 지정된 주소로 이더 전송
        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    // 컨트랙트의 잔액을 조회
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
