const db = require('../data/db-config.js')

module.exports = {
    find,
    findById,
    findSteps,
    add,
    update,
    remove,
    addStep
}
//RETURN RETURN RETURN --- MODEL uses DB which NEEDs RETURN STATEMENTS
function find() {
    return db('schemes')
}

function findById(id) {
    return db('schemes').where({ id }).first()
}

function findSteps(id) {
    /*
select schemes.scheme_name, steps.step_number, steps.instructions
from    schemes 
join steps
    on schemes.id = steps.scheme_id
where schemes.id = 3
order by steps.step_number
    */

    return db('schemes')
        .select( 'schemes.scheme_name', 'steps.*')
        //added scheme_id for visualization purposes -- let's me see if I'm getting the right data more easily
        .join('steps', 'schemes.id', 'steps.scheme_id')
        .where('scheme_id', '=', id)
        .orderBy('steps.step_number')

}

function add(scheme) {
    return db('schemes').insert(scheme, 'id')
        .then(([id]) => {
            return findById(id)
        })
}

function update(changes, id) {
    return db('schemes').where({ id }).update(changes)
        .then(() => {
            return findById(id)
        })
}

// async function remove(id) {
//     try {
//         const deleted = await findById(id)
//         return db('schemes').where({ id }).del()
//             .then(() => {
//                 return deleted
//             })
//     } catch (err) {
//         console.log(err.message)
//     }
// }

function remove(id) {
  return findById(id).then( deleted => {
     return  db('schemes').where({id}).del().then(() => {
         return deleted
     })  
   })
}

//~~~~~~~~STRETCH~~~~~~~~
function addStep(step, scheme_id) {
    return db('steps').where('scheme_id', scheme_id).insert(step,'id')
    .then(([id]) =>{
        return db('steps').where({id}).first()
    })
}