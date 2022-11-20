iFGBLoanAbi = [
	{
		"inputs": [],
		"name": "cancel",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_cancelled",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "credit",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_balance",
				"type": "uint256"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "drawDown",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_payoutAmount",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getBasis",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "borrower",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "borrowerAddress",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "collateral",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "loanAmount",
						"type": "uint256"
					},
					{
						"internalType": "uint256[]",
						"name": "dealBasis",
						"type": "uint256[]"
					},
					{
						"internalType": "address",
						"name": "greenFilNft",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "greenFilNftId",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "createDate",
						"type": "uint256"
					}
				],
				"internalType": "struct IFGBLoan.LoanBasis",
				"name": "_basis",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getConditions",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "interest",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "expiryDate",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "liquidationFactor",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "minimumRepayment",
						"type": "uint256"
					}
				],
				"internalType": "struct IFGBLoan.LoanConditions",
				"name": "_conditions",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getDrawDownTx",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "amount",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "date",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "drawer",
						"type": "address"
					}
				],
				"internalType": "struct IFGBLoan.DrawDownTx",
				"name": "_drawDown",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getOutstandingBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_outstandingBalance",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getRepayments",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "amount",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "date",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "payer",
						"type": "address"
					}
				],
				"internalType": "struct IFGBLoan.Repayment[]",
				"name": "_repayments",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_repayment",
				"type": "uint256"
			}
		],
		"name": "repay",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_outstandingBalance",
				"type": "uint256"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	}
]