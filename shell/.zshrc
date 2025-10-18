# Ubicación del historial
HISTFILE=~/.zsh_history

# Activar autocompletado en Zsh
autoload -Uz compinit
compinit


# Número de comandos a guardar
HISTSIZE=10000
SAVEHIST=10000

# Opciones recomendadas
setopt append_history       # No sobrescribe el historial
setopt hist_ignore_dups     # Ignora duplicados consecutivos
setopt share_history        # Comparte historial entre sesiones
setopt inc_append_history   # Guarda comandos inmediatamente



eval "$(starship init zsh)"

# Hook para evaluar batería antes del prompt
# precmd() {
#   ~/.config/starship/battery-alert.sh
# }
# Hook para evaluar batería antes del prompt
precmd() {
  battery_level=$(cat /sys/class/power_supply/BAT0/capacity)

  if (( battery_level < 15 )); then
    export STARSHIP_BATTERY_ALERT="low"
  else
    export STARSHIP_BATTERY_ALERT="ok"
  fi

  echo "Battery script ejecutado: $(date)" >> /tmp/battery.log

  # Notificación solo si batería < 10% y no se ha notificado recientemente
  if (( battery_level < 10 )); then
    local last_alert_file="/tmp/last_battery_alert"
    local now=$(date +%s)
    local last=$(cat $last_alert_file 2>/dev/null || echo 0)
    if (( now - last > 600 )); then
      notify-send "⚠️ Batería crítica: ${battery_level}%"
      echo $now > $last_alert_file
    fi
  fi
}

function minimal_path() {
  local full_path="${PWD/#$HOME/~}"
  local IFS='/'
  local parts=($full_path)
  local first="${parts[1]}"
  local last="${parts[-1]}"
  export STARSHIP_MIN_PATH="$first/…/$last"
}
precmd_functions+=(minimal_path)


function base_and_last_dir() {
  local full_path="${PWD/#$HOME/~}"
  local IFS='/'
  local parts=($full_path)

  local first="${parts[1]}"
  local last="${parts[-1]}"

  # Si estás en ~, ambos serán iguales
  if [[ "$first" == "~" && "$last" == "~" ]]; then
    export STARSHIP_DIR_SEGMENTS="~"
  else
    export STARSHIP_DIR_SEGMENTS="$first/…/$last"
  fi
}
precmd_functions+=(base_and_last_dir)





# Aliases for dnf / yum commands

# alias_dnf() {
    
#     alias dint='sudo dnf install "$@"'
#     alias dsea='sudo dnf search "$@"'
#     alias drem='sudo dnf remove "$@"'
#     alias dupd='echo -e "> sudo dnf check-update\n" && sudo dnf check-update'

#     # DUPD="sudo dnf check update"
#     # alias dupd="echo -e $DUPD && $DUPD"
#     alias dinf='sudo dnf info "$@"'
#     alias dupg='sudo dnf upgrade '
    
# }

# alias_dnf() {
#     # Instalación de paquetes
#     alias dint='echo -e "\033[1;32m> sudo dnf install \"$@\"\033[0m\n" && sudo dnf install "$@"'
#     alias drem='echo -e "\033[1;32m> sudo dnf remove \"$@\"\033[0m\n" && sudo dnf remove "$@"'

#     # Búsqueda e información
#     alias dsea='echo -e "\033[1;32m> sudo dnf search \"$@\"\033[0m\n" && sudo dnf search "$@"'
#     alias dinf='echo -e "\033[1;32m> sudo dnf info \"$@\"\033[0m\n" && sudo dnf info "$@"'

#     # Actualizaciones
#     alias dupd='echo -e "\033[1;32m> sudo dnf check-update\033[0m\n" && sudo dnf check-update'
#     alias dupg='echo -e "\033[1;32m> sudo dnf upgrade \"$@\"\033[0m\n" && sudo dnf upgrade "$@"'

#     # Limpieza
#     alias dcln='echo -e "\033[1;32m> sudo dnf clean all\033[0m\n" && sudo dnf clean all'
# }

# dnfmod() {
#   local GREEN="\033[1;32m"   # Verde claro para comando
#   local CYAN="\033[1;36m"    # Cian para argumentos
#   local RESET="\033[0m"

#   local CMD="dnf"
#   local ARGS=("$@")

#   # Mostrar comando
#   echo -e "${GREEN}Comando:${RESET} ${GREEN}${CMD}${RESET}"

#   # Mostrar argumentos
#   echo -n -e "${CYAN}Argumentos:${RESET} "
#   for arg in "${ARGS[@]}"; do
#     echo -n -e "${CYAN}${arg} ${RESET}"
#   done
#   echo

#   # Ejecutar el comando
#   "$CMD" "${ARGS[@]}"
# }
# dnfmod() {
#   local GREEN="\033[1;32m"
#   local CYAN="\033[1;36m"
#   local YELLOW="\033[1;33m"
#   local RED="\033[1;31m"
#   local RESET="\033[0m"

#   local CMD="dnf"
#   local ACTION="$1"
#   shift
#   local ARGS=("$@")

#   # Mostrar comando y acción
#   echo -e "${GREEN}Comando:${RESET} ${GREEN}${CMD}${RESET}"
#   echo -e "${YELLOW}Acción:${RESET} ${YELLOW}${ACTION}${RESET}"
#   echo -n -e "${CYAN}Argumentos:${RESET} "
#   for arg in "${ARGS[@]}"; do
#     echo -n -e "${CYAN}${arg} ${RESET}"
#   done
#   echo

#   # Switch por acción
#   case "$ACTION" in
#     install)
#       echo -e ">> $1"
#       $CMD install "${ARGS[@]}"
#       ;;
#     remove)
#       $CMD remove "${ARGS[@]}"
#       ;;
#     buscar)
#       $CMD search "${ARGS[@]}"
#       ;;
#     actualizar)
#       $CMD upgrade "${ARGS[@]}"
#       ;;
#     *)
#       echo -e "${RED}Acción no reconocida:${RESET} ${ACTION}"
#       echo -e "${RED}Usa:${RESET} install | remove | buscar | actualizar"
#       return 1
#       ;;
#   esac
# }

dnfmod() {
  local GREEN="\033[1;32m"
  local CYAN="\033[1;36m"
  local YELLOW="\033[1;33m"
  local RED="\033[1;31m"
  local RESET="\033[0m"

  local SUDO="sudo"
  local CMD="dnf"
  local accion="$1"
  shift
  local ARGS=("$@")

  # Lista de comandos válidos
  local COMANDOS_VALIDOS=("install" "search" "remove" "update" "info" "upgrade")

  # Validar acción
  local es_valido=false
  for cmd in "${COMANDOS_VALIDOS[@]}"; do
    if [[ "$cmd" == "$accion" ]]; then
      es_valido=true
      break
    fi
  done

  if ! $es_valido; then
    echo -e "${RED}❌ Acción no reconocida:${RESET} ${accion}"
    echo -e "${YELLOW}Comandos válidos:${RESET} ${COMANDOS_VALIDOS[*]}"
    return 1
  fi

  # Mostrar comando y argumentos
    echo -e "${GREEN}Comando:${RESET} ${GREEN}${CMD}${RESET}"
  
#   echo -e "${YELLOW}Acción:${RESET} ${YELLOW}${accion}${RESET}"
  echo -e " ${YELLOW}${accion}${RESET}"
  echo -n -e "${CYAN}> Argumentos:${RESET} "
  for arg in "${ARGS[@]}"; do
    echo -n -e "${CYAN}${arg} ${RESET}"
  done
  echo

  # Switch granular por acción
  case "$accion" in
    install)
    #   echo -e "${GREEN}→ Instalando paquetes...${RESET}"
      $SUDO $CMD install "${ARGS[@]}"
      ;;
    search)
    #   echo -e "${GREEN}→ Buscando paquetes...${RESET}"
    #   $CMD search "${ARGS[@]}"
      $CMD search "${ARGS[@]}"
      ;;
    remove)
    #   echo -e "${GREEN}→ Eliminando paquetes...${RESET}"
      $SUDO $CMD remove "${ARGS[@]}"
      ;;
    update)
    #   echo -e "${GREEN}→ Actualizando sistema...${RESET}"
      # $SUDO $CMD check-update "${ARGS[@]}"
      $SUDO "$CMD update "
      ;;
    info)
    #   echo -e "${GREEN}→ Mostrando información...${RESET}"
      $CMD info "${ARGS[@]}"
      ;;
    upgrade)
      echo -e "${GREEN}→ Realizando upgrade...${RESET}"
      $SUDO $CMD upgrade "${ARGS[@]}"
      ;;
  esac
}

alias dnint='dnfmod install'   # dnf install
alias dnrem='dnfmod remove'    # dnf remove
alias dnsea='dnfmod search'    # dnf search
alias dnupd='dnfmod update'    # dnf update
alias dnupg='dnfmod upgrade'   # dnf upgrade
alias dninf='dnfmod info'      # dnf info


# alias systemctl
source ~/.zsh/modules/systemd-shortcuts.zsh



_systemd_services() {
  compadd $(systemctl list-units --type=service --no-pager --no-legend | awk '{print $1}')
}

compdef _systemd_services sstart sstop srest sstat senab sdisb srelo

export PATH="$HOME/bin:$PATH"
