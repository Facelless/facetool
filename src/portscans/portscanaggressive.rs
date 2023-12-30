use std::io::{self, Write};
use std::process::Command;

struct PortScan {
    hostname: String,
}

impl PortScan {
    fn new() -> PortScan {
        PortScan {
            hostname: String::new(),
        }
    }

    fn read_input(prompt: &str) -> String {
        let mut input = String::new();
        print!("{}", prompt);
        io::stdout().flush().unwrap();
        io::stdin().read_line(&mut input).expect("Erro ao ler entrada.");
        input.trim().to_string()
    }

    fn scan_port(&self) {
        let command = "nmap";

        let mut child = Command::new(command)
            .arg("-A")
            .arg(&self.hostname)
            .spawn()
            .expect("Falha ao executar o comando");

        let status = child.wait().expect("Falha ao aguardar processamento");

        println!("Comando executado com sucesso. Status: {:?}", status);
    }
}

fn config_command() {
    let mut portscan = PortScan::new();
    portscan.hostname = PortScan::read_input("[hostname]=# ");
    portscan.scan_port();
}

fn main() {
    config_command();
}
