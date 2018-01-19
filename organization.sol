pragma solidity ^0.4.18;

contract Organization {
    address public owner;
    int public treshold;

    struct Member{
        address member;
        string name;
    }

    struct Proposal{
        address beneficiary;
        mapping (address => bool) voted;
        int score;
        uint amount;
        string description;
    }

    mapping (address => uint) public memberIds;
    Member[] public members;
    Proposal[] public proposals;


    function Organization() payable public{
        owner = msg.sender;

        addMember(owner, 'founder');
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyMembers() {
        require(memberIds[msg.sender] != 0);
        _;
    }



    function addMember(address newMember, string _name) onlyOwner public{
        uint id = members.length++;
        memberIds[newMember] = id;
        members[id] = Member(newMember, _name);

    }

    function addProposal(address benef, uint amount, string description ) onlyMembers public {
        uint id = proposals.length++;
        Proposal storage p = proposals[id];

        p.beneficiary = benef;
        p.amount = amount;
        p.description = description;
    }

    function vote(uint idx, bool support) onlyMembers public {
        Proposal storage p = proposals[idx];

        support ? p.score++ : p.score--;
    }

    function () payable public{

    }
}
