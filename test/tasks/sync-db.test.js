
const { syncDB } = require('../../src/tasks/sync-db');

describe(' Prueba en syncDB ', () => { 

    test('Debe ser llamado dos veces', () => {
       
        syncDB();
        const time = syncDB();

        expect( time ).toBe(2);
    }   );
    

});