const { spawn } = require("child_process");
const { WebhookClient } = require("discord.js");
const { getConfig } = require("raraph84-lib");
const Config = getConfig(__dirname);

const webhook = new WebhookClient({ url: Config.webhook });

/**
 * @param {String} command 
 * @returns {Promise<String>} 
 */
const exec = (command) => new Promise((resolve, reject) => {
    const proc = spawn("bash", ["-c", command]);
    let output = "";
    proc.stdout.on("data", (data) => output += data.toString());
    proc.stderr.on("data", (data) => output += data.toString());
    proc.on("close", (code) => {
        if (code !== 0) reject(code + " " + output);
        else resolve(output);
    });
});

const listBans = async () => {
    const bans = await exec("fail2ban-client get sshd banned");
    return JSON.parse(bans.replace(/'/g, '"'));
}

const send = async (message) => {
    await webhook.send(message);
}

listBans().then((bans) => {

    let lastBans = bans;

    setInterval(async () => {

        const bans = await listBans();

        bans.filter((ban) => !lastBans.includes(ban)).forEach((ban) => {
            send("L'adresse ip `" + ban + "` a été bannie du serveur " + Config.serverName + ".");
        });

        lastBans.filter((ban) => !bans.includes(ban)).forEach((ban) => {
            send("L'adresse ip `" + ban + "` a été débannie du serveur " + Config.serverName + ".");
        });

        lastBans = bans;

    }, 5 * 1000);
});
