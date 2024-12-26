const token = process.argv[2]

// All repos which use the shared theme
let repos = [
    'vanjac.github.io',
    'chromafiler',
    'riscy-save',
    'voxel-editor',
    'aodix-repair',
    'aodix-enhanced',
    'ar-recorder',
    'su-extensions',
    'spans',
    'tapedeck',
    'WingEd',
    'sketches',
    'colortest',
]

/** @type {RequestInit} */
let options = {
    method: 'POST',
    headers: {
        Authorization: 'Bearer ' + token,
    },
}
for (let repo of repos) {
    fetch(`https://api.github.com/repos/vanjac/${repo}/pages/builds`, options)
}
