import intersection from 'lodash/intersection'

export default class UserPreference {
  constructor(useSingleStore) {
    this.useSingleStore = useSingleStore;
    this.platformPreference = this.platforms()
    this.terminalProgramsPreference = this.terminalPrograms()
    this.frameworkPreference = this.frameworks()
  }

  languages() {
    return this.get(this.getKeyFromType('languages'))
  }

  platforms() {
    return this.get(this.getKeyFromType('platforms'))
  }

  terminalPrograms() {
    return this.get(this.getKeyFromType('terminal_programs'))
  }

  frameworks() {
    return this.get(this.getKeyFromType('frameworks'))
  }

  all() {
    return this.platforms().concat(
      this.terminalPrograms(),
      this.languages(),
      this.frameworks()
    )
  }

  getKeyFromType(type) {
    if (this.useSingleStore) {
        return 'preferences.all';
    }
    switch (type) {
      case 'languages': return 'preferences.languages'
      case 'platforms': return 'preferences.platforms'
      case 'terminal_programs': return 'preferences.terminal_programs'
      case 'frameworks': return 'preferences.frameworks'
    }
  }

  getByType(type) {
    switch (type) {
      case 'languages': return this.languages()
      case 'platforms': return this.platforms()
      case 'terminal_programs': return this.terminalPrograms()
      case 'frameworks': return this.frameworks()
    }
  }

  get(key) {
    const value = window.localStorage.getItem(key)
    if (!value) { return [] }
    return JSON.parse(value)
  }

  store(type, value) {
    const key = this.getKeyFromType(type)
    localStorage.setItem(key, JSON.stringify(value))
  }

  promote(type, value) {
    let list = this.getByType(type) || [];
    list = list.filter(item => item !== value)
    list.unshift(value)
    this.store(type, list)
  }

  topMatch(available) {
    const result = intersection(this.all(), available)
    return result[0] || false
  }
}
