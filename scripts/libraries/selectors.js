const FacetCutAction = { Add: 0, Replace: 1, Remove: 2 };

function SelectorCollection(src = null) {
    if (src) {
        if (
            src.constructor == ethers.Contract ||
            src.constructor == ethers.ContractFactory
        ) {
            this.selectorMap = Object.fromEntries(
                Object.keys(src.interface.functions).map((k) => [
                    k,
                    src.interface.getSighash(k),
                ])
            );
        } else if (src.constructor == [].constructor) {
            const abiInterface = new ethers.utils.Interface(src);
            this.selectorMap = Object.fromEntries(
                src.map((func) => [
                    func,
                    abiInterface.getSighash(ethers.utils.Fragment.from(func)),
                ])
            );
        }
    }
}

Object.defineProperty(SelectorCollection.prototype, "selectors", {
    get() {
        return Object.values(this.selectorMap);
    },
});

Object.defineProperty(SelectorCollection.prototype, "functions", {
    get() {
        return Object.keys(this.selectorMap);
    },
});

Object.defineProperty(SelectorCollection.prototype, "interfaceId", {
    get() {
        let interfaceId = ethers.constants.Zero;

        for (let selector of this.selectors) {
            interfaceId = interfaceId.xor(selector);
        }

        return interfaceId;
    },
});

Object.assign(SelectorCollection.prototype, {
    removeSelectors(...selectors) {
        const functions = [];

        for (let [k, v] of Object.entries(this.selectorMap)) {
            if (selectors.includes(v)) {
                functions.push(k);
            }
        }

        return this.removeFunctions(...functions);
    },
    removeFunctions(...functions) {
        for (let func of functions) {
            if (func in this.selectorMap) {
                delete this.selectorMap[func];
            }
        }

        return this;
    },
});

exports.FacetCutAction = FacetCutAction;
exports.selectorCollection = (src) => new SelectorCollection(src);
