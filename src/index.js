const express = require('express')
const open = require('open')
const multiparty = require('multiparty')
const { execFileSync } = require('child_process')
const app = express()

app.use('/', express.static(__dirname + '/public'))


app.post('/epub-to-ogg', async (req, res, next) => {
    const form = new multiparty.Form({autoFiles:true})

    form.on('error', next)
    form.on('file', async (name, file) => {
        console.log('??', name, file.originalFilename, file.path)

        const stdout = execFileSync(__dirname + '/script/script.sh', [file.path])

        console.log('STDOUT = ', stdout.toString())
        // split the stdout to get each line and filter empty lines
        const lines = stdout.toString().split('\n').filter(line => line !== '')

        // last line returned by the screen must be the filename
        const oggPath = lines[lines.length - 1]

        res.download(oggPath, file.originalFilename.replace('.epub','.zip'))
    })


    form.parse(req)
})

app.listen(4242)

open('http://localhost:4242')
