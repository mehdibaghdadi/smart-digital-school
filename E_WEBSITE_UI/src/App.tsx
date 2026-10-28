/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import React, { useState, useEffect } from 'react';
import { Language, translations } from './translations';
import { Navbar } from './components/Navbar';
import { ShowcaseSection } from './components/ShowcaseSection';
import { Hero } from './components/Hero';
import { Mission } from './components/Mission';
import { WhyUs } from './components/WhyUs';
import { HowItWorks } from './components/HowItWorks';
import { AISection } from './components/AISection';
import { Pricing } from './components/Pricing';
import { Contact } from './components/Contact';
import { CTA } from './components/CTA';
import { Footer } from './components/Footer';

export default function App() {
  const [isDark, setIsDark] = useState(false);
  const [lang, setLang] = useState<Language>(() => {
    const browserLang = navigator.language.split('-')[0];
    const supported: Language[] = ['fr', 'en', 'es'];
    return supported.includes(browserLang as Language) ? (browserLang as Language) : 'fr';
  });

  useEffect(() => {
    const root = window.document.documentElement;
    if (isDark) {
      root.classList.add('dark');
    } else {
      root.classList.remove('dark');
    }
  }, [isDark]);

  const toggleTheme = () => setIsDark(!isDark);

  return (
    <div className="min-h-screen selection:bg-brand-100 selection:text-brand-700 bg-white dark:bg-dark-bg transition-colors">
      <Navbar isDark={isDark} toggleTheme={toggleTheme} lang={lang} setLang={setLang} />
      <main>
        <ShowcaseSection lang={lang} />
        <Hero lang={lang} />
        <Mission lang={lang} />
        <WhyUs lang={lang} />
        <HowItWorks lang={lang} />
        <AISection lang={lang} />
        <Pricing lang={lang} />
        <Contact lang={lang} />
        <CTA lang={lang} />
      </main>
      <Footer lang={lang} />
    </div>
  );
}
