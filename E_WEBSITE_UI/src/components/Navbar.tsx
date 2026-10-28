import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { BookOpen, Zap, Clock, Sparkles, TrendingUp, Mail, Menu, X } from 'lucide-react';
import { Language, translations } from '../translations';
import { ThemeToggle } from './ThemeToggle';
import { LanguageToggle } from './LanguageToggle';

export const Navbar = ({ 
  isDark, 
  toggleTheme, 
  lang, 
  setLang 
}: { 
  isDark: boolean; 
  toggleTheme: () => void; 
  lang: Language; 
  setLang: (l: Language) => void;
}) => {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const t = translations[lang].nav;

  useEffect(() => {
    const handleScroll = () => setIsScrolled(window.scrollY > 20);
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const navLinks = [
    { name: t.presentation, href: '#mission', icon: <BookOpen size={14} /> },
    { name: t.solution, href: '#solution', icon: <Zap size={14} /> },
    { name: t.howItWorks, href: '#how-it-works', icon: <Clock size={14} /> },
    { name: t.ai, href: '#ai', icon: <Sparkles size={14} /> },
    { name: t.pricing, href: '#pricing', icon: <TrendingUp size={14} /> },
    { name: t.contact, href: '#contact', icon: <Mail size={14} /> },
  ];
const logo = isDark ? "/logo-sds-dark.png" : "/logo-sds-light.png"
  const loginUrl = {
    fr: import.meta.env.VITE_LOGIN_URL_FR,
    en: import.meta.env.VITE_LOGIN_URL_EN,
    es: import.meta.env.VITE_LOGIN_URL_ES,
  }[lang] || import.meta.env.VITE_LOGIN_URL_FR;

  return (
    <nav className={`fixed top-0 left-0 right-0 z-50 shadow-xl  transition-all duration-300 ${
      isScrolled 
        ? 'bg-white/80 dark:bg-dark-bg/80 backdrop-blur-md py-3' 
        : 'bg-transparent py-5'
    }`}>
      <div className="max-w-7xl mx-auto px-6 flex items-center justify-between">
        <div onClick={() => location.href="#"} className="pr-5">
          <img src={`${logo}`} alt="Logo Smart Digital School"
           style={{minWidth: "80px",maxHeight: "35px",}}
            className="object-contain"/>
         
        </div>

        {/* Desktop Nav */}
        <div className="hidden lg:flex items-center gap-6">
          {navLinks.map((link) => (
            <a 
              key={link.name} 
              href={link.href} 
              className="text-[0.7rem] uppercase font-bold text-slate-600 dark:text-slate-300 hover:text-brand-600 dark:hover:text-brand-500 transition-colors flex items-center gap-1.5"
            >
              {link.icon}
              {link.name}
            </a>
          ))}
          
          <div className="flex items-center gap-3 border-l border-slate-200 dark:border-slate-700 pl-6">
            <LanguageToggle currentLang={lang} setLang={setLang} />
            <ThemeToggle isDark={isDark} toggle={toggleTheme} />
            <a 
              href={loginUrl}
              className="px-5 py-2.5 bg-slate-900 dark:bg-brand-600 text-white text-[0.7rem] uppercase font-bold rounded-full hover:bg-slate-800 dark:hover:bg-brand-700 transition-all"
            >
              {t.login}
            </a>
          </div>
        </div>

        {/* Mobile Toggle */}
        <div className="flex items-center gap-4 lg:hidden">
          <ThemeToggle isDark={isDark} toggle={toggleTheme} />
          <button 
            className="text-slate-900 dark:text-white"
            onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          >
            {isMobileMenuOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      <AnimatePresence>
        {isMobileMenuOpen && (
          <motion.div 
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            className="absolute top-full left-0 right-0 bg-white dark:bg-dark-bg border-b border-slate-100 dark:border-slate-700 p-6 lg:hidden flex flex-col gap-4 shadow-xl"
          >
            {navLinks.map((link) => (
              <a 
                key={link.name} 
                href={link.href} 
                className="text-md font-bold uppercase text-slate-600 dark:text-slate-300 flex items-center gap-3"
                onClick={() => setIsMobileMenuOpen(false)}
              >
                {link.icon}
                {link.name}
              </a>
            ))}
            <div className="flex items-center justify-between py-2 border-t border-slate-100 dark:border-slate-700 mt-2">
              <span className="text-sm font-medium text-slate-500">Langue</span>
              <LanguageToggle currentLang={lang} setLang={setLang} />
            </div>
            <a 
              href={loginUrl}
              className="w-full py-3 bg-brand-600 text-white text-center font-bold rounded-xl"
            >
              {t.login}
            </a>
          </motion.div>
        )}
      </AnimatePresence>
    </nav>
  );
};
