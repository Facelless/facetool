use std::io::{self, Write};
use std::process::Command;

struct PageScan {
    site: String,
}

impl PageScan {
    fn new() -> PageScan {
        PageScan {
            site: String::new(),
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
            .arg("-n")
            .arg("--script")
            .arg("https-enum")
            .arg(&self.site)
            .spawn()
            .expect("Falha ao executar o comando");

        let status = child.wait().expect("Falha ao aguardar processamento");

        println!("Comando executado com sucesso. Status: {:?}", status);
    }
}

fn config_command() {
    let mut site = PageScan::new();
    site.site = PageScan::read_input("[hostname]=# ");
    site.scan_port();
}

fn main() {
    config_command();
}
