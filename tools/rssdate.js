'use strict'

/**
 * @param {Date} date
 * @returns {string}
 */
function formatRSSDate(date) {
    let weekday = new Intl.DateTimeFormat('en-US', {weekday: 'short'}).format(date)
    let day = new Intl.DateTimeFormat('en-US', {day: '2-digit'}).format(date)
    let month = new Intl.DateTimeFormat('en-US', {month: 'short'}).format(date)
    let year = new Intl.DateTimeFormat('en-US', {year: 'numeric'}).format(date)
    let time = new Intl.DateTimeFormat('en-US', {
        hour12: false,
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        timeZoneName: 'short',
    }).format(date)
    return `${weekday}, ${day} ${month} ${year} ${time}`
}

console.log(formatRSSDate(new Date()))
