iFGBLendingMarketAbi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_minerAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_requestedTerm",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_loanAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256[]",
				"name": "_collateralDeals",
				"type": "uint256[]"
			},
			{
				"internalType": "address",
				"name": "_greenFilNftContract",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_greenFilNftId",
				"type": "uint256"
			}
		],
		"name": "borrow",
		"outputs": [
			{
				"internalType": "address",
				"name": "_loanContract",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getAvailableFunds",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_funds",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getOutstandingCapital",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_outstandingCapital",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getOutstandingLoans",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_outstandingLoans",
				"type": "address[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getProjectedEarnings",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_earnedAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_latestDate",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_maxTerm",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_funds",
				"type": "uint256"
			}
		],
		"name": "lend",
		"outputs": [
			{
				"internalType": "address",
				"name": "_bondContract",
				"type": "address"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	}
]