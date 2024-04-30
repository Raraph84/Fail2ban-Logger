const { spawn } = require("child_process");
const config = require("./config.json");

const send = (message) => fetch(config.webhookUrl, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ content: message }) });

const listen = () => {
    const proc = spawn("tail", ["-n", "0", "-F", "/var/log/fail2ban.log"]);
    let output = "";
    const onData = (data) => {
        output += data;
        while (output.includes("\n")) {
            const line = output.slice(0, output.indexOf("\n"));
            output = output.slice(output.indexOf("\n") + 1);
            if (line.includes("Ban ")) {
                const ip = line.slice(line.indexOf("Ban ") + "Ban ".length);
                send("L'adresse IP `" + ip + "` a été bannie du serveur " + config.serverName + ".");
            } else if (line.includes("Unban ")) {
                const ip = line.slice(line.indexOf("Unban ") + "Unban ".length);
                send("L'adresse IP `" + ip + "` a été débannie du serveur " + config.serverName + ".");
            }
        }
    };
    proc.stdout.on("data", (data) => onData(data.toString()));
    proc.stderr.on("data", (data) => onData(data.toString()));
    proc.on("close", (code) => {
        console.log("Tail closed with code " + code + ", restarting...");
        setTimeout(() => listen(), 1000);
    });
};

listen();
