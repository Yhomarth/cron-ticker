
let times = 0;

const syncDB = () => {
    times++;
    console.log('Tick cada multiplo de 5 segundos :', times);

    return times;w
}

module.exports = {
    syncDB
}