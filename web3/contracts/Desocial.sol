
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <=0.9.0;

contract Desocial {
    struct Post {
        address owner;
        string description;
        string image;
        string[] comments;
        uint256 likes;
        uint256[] tips;
        address[] tippers;
        uint totalTip;
    }

    uint256 public totalPost = 0;
    mapping(uint256 => Post) public allPost;

    function createPost(
        address _owner,
        string memory _desc,
        string memory _img
      
    ) public returns (uint256) {
        Post storage post = allPost[totalPost];

        post.owner = _owner;
        post.description = _desc;
        post.image = _img;
        post.likes = 0;
        post.totalTip=0;

        totalPost++;

        return totalPost - 1;
    }

    function getAllPost() public view returns (Post[] memory) {
        Post[] memory posts = new Post[](totalPost);

        for (uint256 i = 0; i < totalPost; i++) {
            Post storage post = allPost[i];
            posts[i] = post;
        }

        return posts;
    }

     function tipToPost(uint postId) public  payable {
                uint amount = 0.1 ether;

        Post storage post=allPost[postId];
        post.tippers.push(msg.sender);
        post.tips.push(amount);

        (bool sent,)=payable (post.owner).call{value:amount}('');
        if(sent){
            post.totalTip=post.totalTip+amount;
        }
    }

    function addLike(uint _postId) public {
        Post storage post=allPost[_postId];

        post.likes++;
    }

    function addComment(uint _postId, string memory _comment) public {
        Post storage post=allPost[_postId];
        post.comments.push(_comment);
    }



}
