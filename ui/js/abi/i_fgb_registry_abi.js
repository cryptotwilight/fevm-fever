iFGBRegistryAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"name": "getAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"name": "getName",
		"outputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "listConfiguration",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "veAddress",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "version",
						"type": "uint256"
					}
				],
				"internalType": "struct IFGBRegistry.VersionedEntry[]",
				"name": "_entries",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]