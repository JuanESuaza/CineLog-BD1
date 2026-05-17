import { Component, signal } from '@angular/core';
import { RouterLink, RouterLinkActive, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, CommonModule, FormsModule],
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent {
  scrolled = signal(false);
  searchOpen = signal(false);
  menuOpen = signal(false);
  searchQuery = '';

  constructor(public auth: AuthService, private router: Router) {
    window.addEventListener('scroll', () => this.scrolled.set(window.scrollY > 50));
  }

  toggleSearch() { this.searchOpen.update(v => !v); if (!this.searchOpen()) this.searchQuery = ''; }
  toggleMenu() { this.menuOpen.update(v => !v); }
  closeMenu() { this.menuOpen.set(false); }
  setSearch(val: boolean) { this.searchOpen.set(val); }

  onSearch(event: KeyboardEvent) {
    if (event.key === 'Enter' && this.searchQuery.trim()) {
      this.router.navigate(['/home'], { queryParams: { busqueda: this.searchQuery.trim() } });
      this.searchOpen.set(false);
    }
  }
  logout() { this.auth.logout(); this.menuOpen.set(false); }
}
