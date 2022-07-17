let balances;

function balanceOf(acc) {
    return tokensOf(acc).length;
}

function tokensOf(acc) {
    return balances[acc.address].tokens;
}

async function onUpdateBalanceOf(acc, amount) {
    const balance = balances[acc.address];
    balance.promise = balance.tokens.length + amount;

    return new Promise((resolve) => {
        balance.resolve = resolve;
    });
}

function initBalances(accs) {
    balances = Object.fromEntries(
        [{ address: ethers.constants.AddressZero }, ...accs].map((acc) => [
            acc.address,
            { mintBalance: 0, tokens: [] },
        ])
    );
}

function onTransfer(from, to, tokenId) {
    const balance = balances[to];
    balance.tokens.push(tokenId);

    if (from == ethers.constants.AddressZero) {
        balance.mintBalance++;
    } else {
        const i = balances[from].tokens
            .map((tid, i) => [tid, i])
            .filter(([tid]) => tid.toString() == tokenId.toString())[0][1];
        balances[from].tokens.splice(i, 1);
        afterTransfer(from);
    }

    afterTransfer(to);
}

function afterTransfer(owner) {
    const balance = balances[owner];

    if (balance.promise == balance.tokens.length && balance.resolve) {
        balance.resolve();
        balance.promise = balance.resolve = null;
    }
}

exports.tokensOf = tokensOf;
exports.balanceOf = balanceOf;
exports.initBalances = initBalances;
exports.onUpdateBalanceOf = onUpdateBalanceOf;
exports.onTransfer = onTransfer;
