llm_ollama() {
    local cmd="$1"
    local model="${AI_COMMAND_ASISTANT_MODEL:-qwen2.5:32b-instruct}"
    local ollama_url="${AI_COMMAND_ASISTANT_OLLAMA_URL:-http://localhost:11434}"
    
    curl -s -X POST "$ollama_url/api/generate" \
        -H "Content-Type: application/json" \
        -d '{"model": "'"$model"'", "prompt": "I mistyped the following command in my terminal: '"$cmd"'. Correct it and return only the corrected command without any additional text or explanation.", "stream": false}' | jq -r '.response'
}

command_not_found_handle() {
    local cmd="$*"
    local response
    
    echo "Command '$cmd' not found. Checking with AI assistant..."
    
    local ai_assistant="${AI_COMMAND_ASISTANT_LLM:-ollama}"
    local function_name="llm_${ai_assistant}"
    
    if declare -f "$function_name" > /dev/null; then
        response=$("$function_name" "$cmd")
    else
        echo "Error: Model '$ai_assistant' not found."
        return 127
    fi
    
    if [ -n "$response" ]; then
        echo "Did you mean: $response? (y/n)"
        read -n 1 -r confirm
        echo
        if [ "$confirm" = "y" ]; then
            eval "$response"
            return
        fi
    fi
    
    echo "Could not determine a valid command."
    return 127
}