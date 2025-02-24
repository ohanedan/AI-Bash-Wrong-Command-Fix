# AI Wrong Command Fix

## Overview
AI Wrong Command Fix is a Bash script that enhances the command-line experience by integrating AI-powered command correction. When a user mistypes a command, this script queries an AI assistant (default: Ollama) to suggest the correct command. The user can then choose to execute the suggested command automatically.

## Features
- Detects mistyped commands in the terminal.
- Queries an AI model to suggest the correct command.
- Asks for user confirmation before executing the suggestion.
- Easily extendable to support different AI models.

## Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```
2. Add the script to your `.bashrc` or `.bash_profile`:
   ```bash
   echo 'source /path/to/command_not_found_ai.sh' >> ~/.bashrc
   source ~/.bashrc
   ```

## Configuration
The script uses environment variables for customization:

- `AI_COMMAND_ASISTANT_LLM` (default: `ollama`) – The AI backend to use.
- `AI_COMMAND_ASISTANT_MODEL` (default: `qwen2.5:32b-instruct`) – The model used by the AI backend.
- `AI_COMMAND_ASISTANT_OLLAMA_URL` (default: `http://localhost:11434`) – The URL for the Ollama AI service.

To customize these, add the variables to your shell configuration:
```bash
export AI_COMMAND_ASISTANT_LLM=ollama
export AI_COMMAND_ASISTANT_MODEL=qwen2.5:32b-instruct
export AI_COMMAND_ASISTANT_OLLAMA_URL=http://localhost:11434
```

## Usage
Simply mistype a command in the terminal, and the script will attempt to correct it. Example:
```bash
$ gti status
Command 'gti status' not found. Checking with AI assistant...
Did you mean: git status? (y/n)
```
Press `y` to execute the suggested command, or `n` to ignore it.

## Adding Support for Other AI Models
The script is designed to be extensible. To add a new AI model:
1. Define a new function `llm_<model_name>()` that handles requests to the desired AI service.
2. Ensure the function name matches the value of `AI_COMMAND_ASISTANT_LLM`.

## License
This project is licensed under the MIT License.

## Contributions
Contributions are welcome! Feel free to open an issue or submit a pull request.

